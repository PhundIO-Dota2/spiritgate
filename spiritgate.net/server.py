from flask import *

import glob
import os
import json
import requests
import sys
import subprocess

import sqlite3

import stripe

from authomatic.adapters import *
from authomatic import *
from config import CONFIG

app = Flask(__name__)

DATABASE = 'db/testing.db'
steam_api_key = "B9588C1620F2FDF54261B651245AE537"
authomatic = Authomatic(CONFIG, 'random secret string for session signing', report_errors=False)

def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = sqlite3.connect(DATABASE)
    return db

@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()

def query_db(query, args=(), one=False):
    cur = get_db().execute(query, args)
    rv = cur.fetchall()
    cur.close()
    return (rv[0] if rv else None) if one else rv

@app.route("/crossdomain.xml")
def crossdomain_xml():
	return send_from_directory('static', 'crossdomain.xml')

@app.route("/js/<path:filename>")
def js(filename):
	return send_from_directory('static/js', filename)
@app.route("/css/<path:filename>")
def css(filename):
	return send_from_directory('static/css', filename)
@app.route("/fonts/<path:filename>")
def fonts(filename):
	return send_from_directory('static/fonts', filename)
@app.route("/image/<path:filename>")
def image(filename):
	return send_from_directory('static/image', filename)
@app.route("/waystones/swf/<path:filename>")
def swf(filename):
	return send_from_directory('static/waystones/export/flash/bin/', filename)

@app.route("/page/<path:filename>")
def page(filename):
	return render_template("/page/" + filename,)

@app.route("/")
@app.route("/index/")
def index():
	return render_template('index.html')

@app.route("/balancelog.html")
def balance_log():
	log = query_db("SELECT * FROM balance_log")
	return render_template('balancelog.html', log=log, current_funds='${:,.2f}'.format(sum(int(v) for _,_,v in log)/100))
@app.route("/spendingpolicy.html")
def spending_policy():
	return render_template('spendingpolicy.html')

@app.route("/waystones")
def waystones():
	return render_template("waystones.html")
@app.route("/inventory/<item>")
def inventory(item):
	return render_template('inventory.html', item_type=item)

@app.route('/create_account/', methods=['POST'])
def create_account():
	if len(query_db("SELECT email FROM users where email=?", [request.form['email']])) > 0:
		return "incorrect_email"
	query_db("INSERT INTO users(email, password, karma, clearance, packs) VALUES(?, ?, '0', '0', '');", [request.form['email'], request.form['password']])
	get_db().commit()
	session['user'] = request.form['email']
	return "success"

@app.route('/login/', methods=['GET', 'POST'])
def login():
	password_query_result = query_db("SELECT password FROM users where email=?", [request.form['email']])
	if len(password_query_result) > 0:
		if request.form['password'] == password_query_result[0][0]:
			session['user'] = request.form['email']
			return "success"
		else:
			return "incorrect_password"
	else:
		return "incorrect_email"
	return "disaster"

@app.route('/logout/', methods=['POST'])
def logout():
	session.pop('user')
	return ""

@app.route('/login/steam/', methods=['GET', 'POST'])
def login_steam():
	response = make_response()
	result = authomatic.login(WerkzeugAdapter(request, response), "steam")

	if result:
		if result.user:
			result.user.update()
			if 'user' in session:
				steamid = result.user.id.replace("http://steamcommunity.com/openid/id/", "")
				query_db("UPDATE users SET steamid=? WHERE email=?;", [steamid, session['user']])
				get_db().commit()
				
			return redirect(url_for("index"))
	return response


@app.route('/unlink/steam/', methods=['POST'])
def unlink_steam():
	query_db("UPDATE users SET steamid=? WHERE email=?;", [None, session['user']])
	get_db().commit()
	return "Success"

def get_public_key():
	return "pk_live_bgVlq5H3BFQqEU2196avCDkc"

@app.route('/purchasepack/<pack>')
def purchase_pack_html(pack):
	return render_template("purchasepack.html", pack=pack)

@app.route('/purchasepack/<pack>', methods=['POST'])
def purchase_pack(pack):
	if not pack in query_db("SELECT name FROM supporter_packs")[0]:
		return "Error: Tried to purchase pack that doesn't exist, your card has not been charged"
	owned_packs = query_db("SELECT packs FROM users where email=?", [session['user']], one=True)[0].split(";")
	if pack in owned_packs:
		return "Error: Tried to purchase pack that was already owned, your card has not been charged"
	
	token = request.form['stripeToken']
	try:
		cost = query_db("SELECT cost FROM supporter_packs WHERE name=?", [pack], one=True)[0]
		charge = stripe.Charge.create(
			amount=cost,
			currency="usd",
			source=token,
			description="Example charge"
		)
		query_db("UPDATE users SET packs=packs||+\'" + pack + ";\' WHERE email=?;", [session['user']]) #TODO: Add pack instead of setting
		query_db("UPDATE users SET karma=karma+" + str(int(cost / 10)) + " where email=?", [session['user']])
		query_db("INSERT INTO balance_log (Subject, Amount) VALUES('Spirited Supporter Pack', '941')")
		get_db().commit()
		return "Success!"

	except stripe.error.CardError as e:
		return print(e.json_body)

	return "????"

@app.route('/api/get_skins/<steamid>')
def api_get_skins(steamid):
	all_skins = []
	query_result = query_db("SELECT packs from users where steamid=?", [steamid], one=True)
	if query_result != None:
		packs = query_result[0].split(";")[:-1]
		for pack in packs:
			skins = query_db("SELECT skins from supporter_packs where name=?", [pack], one=True)[0].split(";")[:-1]
			all_skins += skins
	skin_str = ""
	for skin in all_skins:
		skin_str = skin_str + skin + ","
	if skin_str.endswith(","):
		skin_str = skin_str[:-1]
	return skin_str

@app.route('/api/get_waystones')
def api_get_waystones():
	out = []
	for waystone in query_db("SELECT item_list FROM free_items WHERE item_type='waystones'")[0][0].split(";"):
		out.append({ 
			"name": waystone, 
			"shape": query_db('SELECT shape FROM waystones WHERE name=?', [waystone])[0][0], 
			"properties": query_db('SELECT properties FROM waystones WHERE name=?', [waystone])[0][0]
		})
	return json.dumps(out)

@app.route('/api/get_all_waystones')
def api_get_all_waystones():
	out = []
	for waystone in query_db("SELECT item_list FROM free_items WHERE item_type='waystones'")[0][0].split(";"):
		out.append({ 
			"name": waystone, 
			"shape": query_db('SELECT shape FROM waystones WHERE name=?', [waystone])[0][0], 
			"properties": query_db('SELECT properties FROM waystones WHERE name=?', [waystone])[0][0]
		})
	return json.dumps(out)

@app.route('/api/set_loadout/<loadout_name>', methods=['GET'])
def api_set_loadout(loadout_name):
	stone_data = str(request.args.get('loadout'))
	if(stone_data[-1:] == ";"):
		stone_data = stone_data[:-1]
	loadouts = query_db("SELECT custom_loadouts FROM users WHERE email=?", [session['user']])[0][0];
	found_existing = False

	if loadouts != None:
		for loadout in loadouts.split("$"):
			existing_loadout_name = loadout.split(":")[0]
			if existing_loadout_name == "loadout" + loadout_name:
				loadouts = loadouts.replace(loadout, "loadout" + loadout_name + ":" + stone_data)
				found_existing = True
	else:
		loadouts = "";

	if not found_existing:
		loadouts = loadouts + "loadout" + loadout_name + ":" + stone_data + "$"

	query_db("UPDATE users SET custom_loadouts=? WHERE email=?", [loadouts, session['user']])
	get_db().commit()

	return "success"

@app.route('/api/get_loadout/<loadout_name>', methods=['GET'])
def api_get_loadout(loadout_name):
	stone_data = str(request.args.get('loadout'))
	if(stone_data[-1:] == ";"):
		stone_data = stone_data[:-1]

	loadouts = query_db("SELECT custom_loadouts FROM users WHERE email=?", [session['user']])[0][0];

	if loadouts != None:
		for loadout in loadouts.split("$"):
			existing_loadout_name = loadout.split(":")[0]
			if existing_loadout_name == "loadout" + loadout_name:
				return loadout.split(":")[1]

	return "error";
@app.route('/api/get_loadout/<steamid>/<loadout_name>', methods=['GET'])
def api_get_loadout_by_steamid(steamid, loadout_name):
	stone_data = str(request.args.get('loadout'))
	if(stone_data[-1:] == ";"):
		stone_data = stone_data[:-1]

	loadouts = query_db("SELECT custom_loadouts FROM users WHERE steamid=?", [steamid])[0][0];

	if loadouts != None:
		for loadout in loadouts.split("$"):
			existing_loadout_name = loadout.split(":")[0]
			if existing_loadout_name == "loadout" + loadout_name:
				return loadout.split(":")[1]

	return "error";
@app.route('/api/get_loadout_stats/<steamid>/<loadout_name>', methods=['GET'])
def api_get_loadout_stats_by_steamid(steamid, loadout_name):
	stone_data = str(request.args.get('loadout'))
	if(stone_data[-1:] == ";"):
		stone_data = stone_data[:-1]

	loadouts = query_db("SELECT custom_loadouts FROM users WHERE steamid=?", [steamid])[0][0];

	if loadouts != None:
		for loadout in loadouts.split("$"):
			existing_loadout_name = loadout.split(":")[0]
			if existing_loadout_name == "loadout" + loadout_name:
				stats = {}
				loadout_info = loadout.split(":")[1]
				for stone in loadout_info.split(";"):
					stone_properties = query_db("SELECT properties FROM waystones WHERE name=?", [stone.split("@")[0]])[0][0]
					for stone_property in stone_properties.split(";"):
						property_name = stone_property.split(":")[0]
						if property_name == "unique passive":
							if not property_name in stats:
								stats[property_name] = []
							stats[property_name].append(stone_property.split(":")[1])
						else:
							if property_name in stats:
								stats[property_name] += round(float(stone_property.split(":")[1]) * 100) / 100
							else:
								stats[property_name] = round(float(stone_property.split(":")[1]) * 100) / 100

				return json.dumps(stats)

	return "error";

def get_steam_info(user_id):
	request_url = "http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=" + steam_api_key + "&steamids=" + user_id
	try:
		return requests.get(request_url, timeout=0.5).json()['response']['players'][0]
	except:
		return "Error!"

def get_sep():
	return os.path.sep

@app.context_processor
def get_context_processor():
	return dict(query_db=query_db, get_steam_info=get_steam_info, get_public_key=get_public_key, glob=glob.glob, get_sep=get_sep)

if __name__ == "__main__":
	stripe.api_key = "sk_live_MSfzbd3qLTt7tM076qWM9PtD"
	app.secret_key = 'spiritgate_super_secret'
	app.run(debug=True, host='0.0.0.0', port=int(sys.argv[1]))