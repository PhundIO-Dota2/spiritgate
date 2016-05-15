//var PlayerInfoItems = $("#PlayerInfoItems")

var exp_table = [200, 350] //Build the exp table. 
var increase = 330
for(var i = 2; i < 40; i++) {
	exp_table[i] = exp_table[i - 1] + increase
	increase += 90
}

/*for(var i = 0; i < 6; i++) { //6 item placeholders
	var PlayerInfoItem = $.CreatePanel("Panel", PlayerInfoItems, "PlayerInfoItem" + i)
	PlayerInfoItem.AddClass("even-space-vertical")
	PlayerInfoItem.AddClass("fill")
	PlayerInfoItem.AddClass("square")
	PlayerInfoItem.style.backgroundColor = "red"
	if(i != 0) {
		PlayerInfoItem.style.marginTop = "4px"
	}
}*/

function showPowerTooltip() {
	var local_pid = Players.GetLocalPlayer()
	var local_hero = Players.GetPlayerHeroEntityIndex(local_pid)

	var damage = parseInt($("#PlayerInfoStatsAttackDamageLabel").text)
	var haste = parseInt($("#PlayerInfoStatsHasteLabel").text)

	$.DispatchEvent('DOTAShowTextTooltip', $("#PlayerInfoStatsPower"), 
			"Increases effectiveness of your abilities and basic attacks.<br/><br/>" +
			"<b>Power: </b><font color='#54ff52'>" + $("#PlayerInfoStatsPowerLabel").text + "</font><br/><br/>" +
			"<b>Defense Penetration: </b>" + stats_defense_penetration + "<br/>Causes damage you deal to ignore a flat amount of the target's Armour and Magic Resistance<br/><br/>" +
			"<b>Critical Strike Chance: </b>" + stats_mastery + "%<br/><br/>" +
			"<b>More Spell Damage: </b>" + stats_mastery * 0.5 + "%<br/><br/>" +
			"<b>Lifedrain: </b>" + stats_lifedrain + "%"
	);
}

function hidePowerTooltip() {
	$.DispatchEvent('DOTAHideTextTooltip', $("#PlayerInfoStatsPower"));
}

function showAttackDamageTooltip() {
	var local_pid = Players.GetLocalPlayer()
	var local_hero = Players.GetPlayerHeroEntityIndex(local_pid)

	var damage = parseInt($("#PlayerInfoStatsAttackDamageLabel").text)
	var haste = parseInt($("#PlayerInfoStatsHasteLabel").text)

	$.DispatchEvent('DOTAShowTextTooltip', $("#PlayerInfoStatsAttackDamage"), 
			"The damage dealt by basic attacks before armour is applied.<br/><br/>" +
			"<b>Attack Damage: </b>" + damage + "| DPS: " + Math.round(Entities.GetAttackSpeed(local_hero) * damage * 10) / 10 + "<br/><br/>" + 
			"<b>Attack Speed: </b>" + Math.round(Entities.GetAttackSpeed(local_hero) * 100) / 100 + " per second<br/>You gain " + stats_attack_speed / haste + "% attack speed per point of haste<br/><br/>" +
			"<b>Critical Strike Chance: </b>" + stats_mastery + "%<br/><br/>" +
			"<b>Attack Range: </b>" + Entities.GetAttackRange(local_hero)
	);
}

function hideAttackDamageTooltip() {
	$.DispatchEvent('DOTAHideTextTooltip', $("#PlayerInfoStatsAttackDamage"));
}

function showHasteTooltip() {
	var haste = parseInt($("#PlayerInfoStatsHasteLabel").text)
	$.DispatchEvent('DOTAShowTextTooltip', $("#PlayerInfoStatsHaste"), 
			"Haste increases attack speed, cooldown reduction, and movement speed.<br/><br/>" +
			"<b>Current Haste: </b><font color='#d1deff'>" + $("#PlayerInfoStatsHasteLabel").text + "</font><br/><br/>" +
			"<b>Bonus Attack Speed: </b>" + stats_attack_speed + "%<br/>You gain " + stats_attack_speed / haste + "% attack speed per point of haste<br/><br/>" +
			"<b>Cooldown Reduction: </b>" + stats_cooldown_reduction + "%<br/>Your abilities cooldown " + stats_cooldown_reduction / haste + "% faster per point of haste<br/><br/>" +
			"<b>Bonus Movement Speed: </b>" + haste / 2 + "<br/>All shapers gain 0.5 movement speed per point of haste"
	);
}

function hideHasteTooltip() {
	$.DispatchEvent('DOTAHideTextTooltip', $("#PlayerInfoStatsHaste"));
}

var stats_attack_speed = 0;
var stats_cooldown_reduction = 0;

var stats_attack_damage_power_ratio = 0;
var stats_mastery = 0;

var stats_defense_penetration = 0;
var stats_lifedrain = 0;

function OnSpiritgateTickStats(event) { //Update stats from a custom event.
	stats_attack_speed = event.attack_speed
	stats_cooldown_reduction = event.cooldown_reduction
	stats_attack_damage_power_ratio = event.power_attack_damage_application_ratio
	stats_mastery = event.mastery
	stats_defense_penetration = event.defense_penetration
	stats_lifedrain = event.lifedrain

	$("#PlayerInfoStatsPowerLabel").text = event.power
	$("#PlayerInfoStatsHasteLabel").text = event.haste
	$("#PlayerInfoStatsArmourLabel").text = event.armour
	$("#PlayerInfoStatsMagicResistanceLabel").text = event.magic_resistance

	var local_pid = Players.GetLocalPlayer()
	var local_pid_hero = Players.GetPlayerHeroEntityIndex(local_pid)
	$("#PlayerInfoStatsAttackDamageLabel").text = Entities.GetDamageMax(local_pid_hero)
	$("#PlayerInfoStatsMovespeedLabel").text = Math.round(Entities.GetIdealSpeed(local_pid_hero))

	// var target_exp = exp_table[Entities.GetLevel(local_pid_hero)] - Entities.GetCurrentXP(local_pid_hero) + Entities.GetCurrentXP(local_pid_hero) - exp_table[Entities.GetLevel(local_pid_hero) - 1]
	//EXP Width (Entities.GetCurrentXP(local_pid_hero) - exp_table[Entities.GetLevel(local_pid_hero) - 1]) / target_exp * 100 + "%"
	//EXP Num(Entities.GetCurrentXP(local_pid_hero) - exp_table[Entities.GetLevel(local_pid_hero) - 1]) + "/" + target_exp
}

function OnSpiritgateSelectRole(event) { //From the hero select, one of 4 roles
	$("#PlayerInfoRolePassive").SetImage("file://{images}/custom_game/roles/role_" + event.role + ".png")
}

function OnSpiritgateSelectShaper(event) { //From the hero select, update hero
	update_hud_icons()
}

function OnSpiritgateGameStart(event) { //Only show the main UI once the game has started.
	$.GetContextPanel().AddClass("is-visible")
	$.GetContextPanel().RemoveClass("is-not-visible")

	update_hud_icons()
}

function update_hud_icons() {
	var local_pid = Players.GetLocalPlayer()
	var local_pid_hero = Players.GetPlayerHeroEntityIndex(local_pid)
	var id = 16
	var passive_ability_id = Entities.GetAbility(local_pid_hero, id)
	while(passive_ability_id < 0 && id > 0) {
		id--;
		if(Abilities.GetAbilityName(Entities.GetAbility(local_pid_hero, id)).indexOf("spell_") == -1) {
			passive_ability_id = Entities.GetAbility(local_pid_hero, id)
		}
	}
	$("#PlayerInfoShaperPassive").SetImage("file://{images}/custom_game/spellicons/" + Abilities.GetAbilityTextureName(passive_ability_id) + ".png")
	//$("#PlayerInfoAvatarImage").heroname = event.shaper
}

function OnUpdateInventory() {
	var local_pid = Players.GetLocalPlayer()
	var local_pid_hero = Players.GetPlayerHeroEntityIndex(local_pid)
	for(var i = 0; i < 6; i++) {
		var panel = $("#PanelInventoryItem" + (i + 1))
		panel.RemoveAndDeleteChildren()	
		var item_id = Entities.GetItemInSlot(local_pid_hero, i )
		if(item_id >= 0) {
			var item_name = Abilities.GetAbilityName(item_id)
			var item_pane = $("#PanelInventoryItem" + (i + 1))
			var image_pane = $.CreatePanel("Image", item_pane, "PanelInventoryItemImage" + (i + 1))
			image_pane.AddClass("fill-height")
			image_pane.AddClass("square")
			image_pane.SetImage("file://{images}/custom_game/items/square_items/" + item_name.substring(5) + ".png")
			
			image_pane.SetPanelEvent('onmouseover', function(index) {
				return function() {
					$.DispatchEvent('DOTAShowAbilityTooltip', $("#PanelInventoryItemImage" + (index + 1)), Abilities.GetAbilityName(Entities.GetItemInSlot(local_pid_hero, index)));
				}
			}(i));
			image_pane.SetPanelEvent('onmouseout', function(index) {
				return function() {
					$.DispatchEvent('DOTAHideAbilityTooltip', $("#PanelInventoryItemImage" + (index + 1)));
				}
			}(i));

			var cooldown_pane = $.CreatePanel("Panel", item_pane, "PanelItemCooldown" + (i + 1))
			cooldown_pane.AddClass("inventory_item_cooldown")
		}
	}
}


function OnPlayerSpawn(event) {
	var local_pid = Players.GetLocalPlayer()
	var local_hero = Players.GetPlayerHeroEntityIndex( local_pid )
	$.Schedule(0.1, function() {
		//$("#PlayerInfoAvatarImage").heroname = Entities.GetUnitName(local_hero)
		update_hud_icons()
	})
	
}

GameEvents.Subscribe("SpiritgateTickStats", OnSpiritgateTickStats)

GameEvents.Subscribe("player_spawn", OnPlayerSpawn)
GameEvents.Subscribe("npc_spawned", OnPlayerSpawn)

GameEvents.Subscribe("dota_inventory_changed", OnUpdateInventory)

function TickInventory() {
	var local_pid = Players.GetLocalPlayer()
	var local_hero = Players.GetPlayerHeroEntityIndex( local_pid )
	for(var i = 0; i < 6; i++) {
		var inv_cooldown_panel = $("#PanelItemCooldown" + (i + 1));
		if(inv_cooldown_panel != null) {
			var item = Entities.GetItemInSlot(local_hero, i)
			if(item >= 0) {
				inv_cooldown_panel.style.width = "50%";
				if(Abilities.GetCooldown(item) > 0) {
					inv_cooldown_panel.style.width = Abilities.GetCooldownTimeRemaining(item) / Abilities.GetCooldown(item) * 100 + "%"
				}
				else if(Abilities.GetLevel(item) != 0) {
					inv_cooldown_panel.style.width = "0%"
				}
				else {
					inv_cooldown_panel.style.width = "100%"
				}
			}
		}
	}
	$.Schedule(0.1, TickInventory)
}

TickInventory()

local_role = "Tactician"

function OnSelectRole(data) {
	var local_pid = Players.GetLocalPlayer()
	if(data.pid == local_pid) {
		local_role = data.role
		$("#PlayerInfoRolePassive").SetImage("file://{images}/custom_game/roles/role_" + data.role.toLowerCase() + ".png")
	}
}

function MouseOverRolePassive() {
	var local_pid = Players.GetLocalPlayer()
	var local_hero = Players.GetPlayerHeroEntityIndex( local_pid )

	for(var i = 0; i < Entities.GetNumBuffs(local_hero); i++) {
		var buff_serial = Entities.GetBuff(local_hero, i)
		if(Buffs.GetName(local_hero, buff_serial) == "modifier_role_" + local_role.toLowerCase()) {
			var panel = $("#PlayerInfoRolePassive")
			$.DispatchEvent('DOTAShowBuffTooltip', panel, local_hero, buff_serial, false);
		}
	}
}
function MouseOutRolePassive() {
	var panel = $("#PlayerInfoRolePassive")
	$.DispatchEvent('DOTAHideBuffTooltip', panel);
}

function MouseOverShaperPassive() {
	var local_pid = Players.GetLocalPlayer()
	var local_hero = Players.GetPlayerHeroEntityIndex( local_pid )
	var id = 16
	var passive_ability_id = Entities.GetAbility(local_hero, id)
	while(passive_ability_id < 0 && id > 0) {
		id--;
		if(Abilities.GetAbilityName(Entities.GetAbility(local_hero, id)).indexOf("spell_") == -1) {
			passive_ability_id = Entities.GetAbility(local_hero, id)
		}
	}
	var local_ability = Entities.GetAbility(local_hero, id)
	var panel = $("#PlayerInfoShaperPassive")
	$.DispatchEvent('DOTAShowAbilityTooltipForEntityIndex', panel, Abilities.GetAbilityName(local_ability), local_hero);
}
function MouseOutShaperPassive() {
	var panel = $("#PlayerInfoShaperPassive")
	$.DispatchEvent('DOTAHideAbilityTooltip', panel)
}

var is_locked = false
Game.SpiritgateCenterCamera = function () {
	var local_pid = Players.GetLocalPlayer()
	var local_hero = Players.GetPlayerHeroEntityIndex( local_pid )
	if(!is_locked) {
		GameUI.SetCameraTarget(local_hero)
	}
	else {
		GameUI.SetCameraTarget(-1)
	}
	is_locked = !is_locked
}

GameEvents.Subscribe("SelectRole", OnSelectRole);