package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.plugin.MouseEventManager;
import flixel.util.FlxPoint;
import flixel.util.FlxCollision;
import haxe.Http;
import haxe.Json;

/**
 * A FlxState which can be used for the game's menu.
 */
class MainState extends FlxState {
	
	public var host:String = "http://spiritgate.net/";
	
	public var z0:FlxGroup;
	public var z1:FlxGroup;
	public var z2:FlxGroup;
	public var z3:FlxGroup;
	public var z4:FlxGroup;
	
	public var mouse_collider_sprite:FlxSprite;
	public var scrollbar_sprite:FlxSprite;
	public var stats_text:FlxText;
	public var sidePanel:FlxSprite;
	
	public var draggableWaystones:List<DraggableWaystone> = new List<DraggableWaystone>();
	public var draggableWaystoneTexts:List<FlxText> = new List<FlxText>();
	
	override public function create():Void {
		#if flash
			host = StringTools.replace(flash.external.ExternalInterface.call("window.location.href.toString"), "/waystones", "/");
		#end
		FlxG.autoPause = false;
		
		mouse_collider_sprite = new FlxSprite(0, 0);
		mouse_collider_sprite.loadGraphic("assets/images/mouse_point.png");
		add(mouse_collider_sprite);
		
		z0 = new FlxGroup();
		z1 = new FlxGroup();
		z2 = new FlxGroup();
		z3 = new FlxGroup();
		z4 = new FlxGroup();
		
		add(z0);
		add(z1);
		add(z2);
		add(z3);
		add(z4);
		
		sidePanel = new FlxSprite(-512, -512);
		sidePanel.loadGraphic("assets/images/sidepanel.png");
		z0.add(sidePanel);
		
		var topPanel = new FlxSprite(0, 0);
		topPanel.loadGraphic("assets/images/toparea.png");
		z2.add(topPanel);
		
		stats_text = new FlxText(FlxG.width - 512, 0, 512, "", 14);
		z2.add(stats_text);
		
		scrollbar_sprite = new FlxSprite(FlxG.width - 512 - 23, 100);
		scrollbar_sprite.loadGraphic("assets/images/ScrollBar.png");
		z2.add(scrollbar_sprite);
		
		var grid = new FlxSprite(FlxG.width - 512, FlxG.height - 512);
		grid.loadGraphic("assets/images/grid.png");
		z0.add(grid);
		
		#if desktop
			var waystone_http_request = new Http(host + "api/get_all_waystones");
		#else
			var waystone_http_request = new Http(host + "api/get_waystones");
		#end
		waystone_http_request.onData = function(data) { 
			var json_data = Json.parse(data);
			var index = -1;
			while (json_data[++index] != null) {
				var text = new FlxText(0, 100 + index * 100, 300, json_data[index].name, 16);
				z1.add(text);
				draggableWaystoneTexts.add(text);
				
				var properties = cast(json_data[index].properties, String);
				
				var block = new DraggableWaystone(5, 100 + index * 100 + 22, this, json_data[index].shape, properties.split(";"), json_data[index].name);
				draggableWaystones.add(block);
			}
		}
		waystone_http_request.request();
		
		var loadout_http_request = new Http(host + "api/get_loadout/1");
		loadout_http_request.onData = function(data) {
			if (data != "error") {
				var stones_data = data.split(";");
				for (stone_data in stones_data) {
					var name = stone_data.split("@")[0];
					var stone_pos_data = stone_data.split("@")[1];
					var stone_x = Std.parseInt(stone_pos_data.split(",")[0]);
					var stone_y = Std.parseInt(stone_pos_data.split(",")[1]);
					var stone_angle = Std.parseInt(stone_pos_data.split(",")[2]);
					
					var stone_shape = "";
					var stone_properties = new Array<String>();
					
					for (dragstone in draggableWaystones) {
						if (dragstone.name == name) {
							stone_shape = dragstone.shape;
							stone_properties = dragstone.stone_properties;
						}
					}
					
					var placed_stone = new PlacedWaystone(FlxG.width - 512 + stone_x * 128, FlxG.height - 512 + stone_y * 128, this, stone_shape, stone_properties, name);
					placed_stone.angle = stone_angle;
					waystones.add(placed_stone);
				}
			}
		}
		loadout_http_request.request();
		
		var button = new Button(FlxG.width - 140, FlxG.height - 512 - 50, this, "Save", function() {
			var submit_http_request = new Http(host + "api/set_loadout/1");
			var submit_data = "";
			for (waystone in waystones) {
				var grid_x = Math.round(((waystone.x - FlxG.width + 512) / 128));
				var grid_y = Math.round(((waystone.y - FlxG.height + 512) / 128));
				submit_data += waystone.name + "@" + grid_x + "," + grid_y + "," + waystone.angle % 360 + ";";
			}
			
			submit_http_request.setParameter("loadout", submit_data);
			submit_http_request.onData = function(data) {
				if (data == "success") {
					trace("Success");
				}
			}
			submit_http_request.request(false);
		});
		
		super.create();
	}
	
	public var sprite_following_mouse:FlxSprite;
	
	override public function destroy():Void {
		super.destroy();
	}
	
	var tooltipAppearTimer = 0;
	var tooltip_group:FlxGroup;

	override public function update():Void {
		super.update();
		
		stats_text.text = "Loadout Stats:\n";
		var properties = new Map<String, String>();
		for (waystone in waystones) {
			var stone = cast(waystone, PlacedWaystone);
			for (property in stone.stone_properties) {
				var stone_property = cast(property, String);
				if (!properties.exists(stone_property.split(":")[0])) {
					properties.set(stone_property.split(":")[0], "0");
				}
				if (stone_property.split(":")[0] == "unique passive") {
					properties.set(stone_property.split(":")[0], stone_property.split(":")[1]);
				} else {
					properties.set(stone_property.split(":")[0], "" + (Math.round((Std.parseFloat(properties.get(stone_property.split(":")[0])) + Std.parseFloat(stone_property.split(":")[1])) * 100) / 100));
				}
			}
		}
		for (property in properties.keys()) {
			stats_text.text += "    " + property + ": " + properties[property] + "\n";
		}
		
		mouse_collider_sprite.x = FlxG.mouse.getWorldPosition().x;
		mouse_collider_sprite.y = FlxG.mouse.getWorldPosition().y;
		mouse_collider_sprite.updateHitbox();
		
		var mouseWasOverStone = false;
		for (waystone in draggableWaystones) {
			var stone = cast(waystone, DraggableWaystone);
			if (mouse_collider_sprite.y > 100 && mouse_collider_sprite.x < stone.x + 100 && mouse_collider_sprite.y < stone.y + 100 && mouse_collider_sprite.x > stone.x && mouse_collider_sprite.y > stone.y) {
				if (tooltipAppearTimer < 30) {
					tooltipAppearTimer++;
				} else {
					if (tooltip_group != null) {
						remove(tooltip_group);
					}
					tooltip_group = new FlxGroup();
					add(tooltip_group);
					
					var tooltipBackground = new FlxSprite(stone.x + 100, stone.y);
					tooltipBackground.loadGraphic("assets/images/tooltip.png");
					tooltip_group.add(tooltipBackground);
					
					var titleText = new FlxText(stone.x + 100 + 5, stone.y, 230, stone.name, 13);
					titleText.color = 0x000000;
					
					var bodyText = new FlxText(stone.x + 100 + 25, stone.y + 22, 230, "", 11);
					bodyText.color = 0x111111;
					for (prop in stone.stone_properties) {
						bodyText.text += prop + "\n";
					}
					
					tooltip_group.add(titleText);
					tooltip_group.add(bodyText);
				}
				mouseWasOverStone = true;
			}
		}
		if (!mouseWasOverStone) {
			tooltipAppearTimer = 0;
			if (tooltip_group != null) {
				remove(tooltip_group);
				tooltip_group = null;
			}
		}
		
		if (FlxG.mouse.justPressed) {
			if (FlxCollision.pixelPerfectCheck(mouse_collider_sprite, scrollbar_sprite)) {
				sprite_following_mouse = scrollbar_sprite;
			}
			for (waystone in draggableWaystones) {
				var stone = cast(waystone, DraggableWaystone);
				stone.updateHitbox();
				if (mouse_collider_sprite.y > 100 && mouse_collider_sprite.x < stone.x + 100 && mouse_collider_sprite.y < stone.y + 100 && mouse_collider_sprite.x > stone.x && mouse_collider_sprite.y > stone.y) {
					stone.onMouseDown(stone);
				}
			}
			for (waystone in waystones) {
				var stone = cast(waystone, PlacedWaystone);
				stone.updateHitbox();
				if (FlxCollision.pixelPerfectCheck(mouse_collider_sprite, stone)) {
					stone.onMouseDown(stone);
				}
			}
		}
		if (FlxG.mouse.justReleased) {
			if (sprite_following_mouse == scrollbar_sprite) {
				sprite_following_mouse = null;
			}
			if (Std.is(sprite_following_mouse, DraggableWaystone)) {
				cast(sprite_following_mouse, DraggableWaystone).onMouseUp(sprite_following_mouse);
			}
			if (Std.is(sprite_following_mouse, PlacedWaystone)) {
				cast(sprite_following_mouse, PlacedWaystone).onMouseUp(cast(sprite_following_mouse, PlacedWaystone));
			}
		}
		if (FlxG.mouse.justPressedRight) {
			if (Std.is(sprite_following_mouse, DraggableWaystone)) {
				var stone = cast(sprite_following_mouse, DraggableWaystone);
				stone.angle = stone.angle + 90;
				stone.updateHitbox();
			}
			if (Std.is(sprite_following_mouse, PlacedWaystone)) {
				var stone = cast(sprite_following_mouse, PlacedWaystone);
				stone.angle = stone.angle + 90;
				stone.updateHitbox();
			}
		}
		
		if (sprite_following_mouse != null) {
			var lastPosX = sprite_following_mouse.x;
			var lastPosY = sprite_following_mouse.y;
			sprite_following_mouse.setPosition(FlxG.mouse.x - sprite_following_mouse.frameWidth / 2, FlxG.mouse.y - sprite_following_mouse.frameHeight / 2);
			if (sprite_following_mouse == scrollbar_sprite) {
				sprite_following_mouse.x = lastPosX;
				var scale = ((draggableWaystones.length + 1) * 100 - FlxG.height) / (FlxG.height - 100);
				if (sprite_following_mouse.y > FlxG.height - 63) {
					sprite_following_mouse.y = FlxG.height - 63;
				}
				if (sprite_following_mouse.y < 100) {
					sprite_following_mouse.y = 100;
				}
				var changeY = sprite_following_mouse.y - lastPosY;
				for (waystone in draggableWaystones) {
					waystone.y -= changeY * scale;
				}
				for (waystone in draggableWaystoneTexts) {
					waystone.y -= changeY * scale;
				}
			}
		}
	}
	
	public var waystones:List<PlacedWaystone> = new List<PlacedWaystone>();
	
	public function place(waystone:PlacedWaystone) {
		waystones.add(waystone);
	}
	
	public function isValidPlacement(grid_x:Int, grid_y:Int, waystone:PlacedWaystone):Bool {
		trace(grid_x + "," + grid_y);
		if (grid_x <= -4 || grid_y <= -4 || grid_x >= 7 || grid_y >= 7) {
			return false;
		}
		if (FlxCollision.pixelPerfectCheck(waystone, sidePanel)) {
			return false;
		}
		for (otherWaystone in waystones) {
			if (FlxCollision.pixelPerfectCheck(waystone, otherWaystone)) {
				return false;
			}
		}
		return true;
	}
}