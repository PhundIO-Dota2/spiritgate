var map_size = 17500

var MAX_Y = 0.84
var MIN_Y = 0.0
var MAX_X = 0.89
var MIN_X = 0.075

function getXOffset(panel) {
	if(panel.GetParent() != null) {
		return getXOffset(panel.GetParent()) + panel.actualxoffset
	}
	return panel.actualxoffset
}
function getYOffset(panel) {
	if(panel.GetParent() != null) {
		return getYOffset(panel.GetParent()) + panel.actualyoffset
	}
	return panel.actualyoffset
}

function click_minimap() {
	var cursor_x = GameUI.GetCursorPosition()[0]
	var cursor_y = GameUI.GetCursorPosition()[1]

	var map_relative_x = Math.min(Math.max((cursor_x - getXOffset($("#MinimapPanel"))) / $("#MinimapPanel").actuallayoutwidth, MIN_X), MAX_X)
	var map_relative_y = Math.min(Math.max((cursor_y - getYOffset($("#MinimapPanel"))) / $("#MinimapPanel").actuallayoutheight, MIN_Y), MAX_Y)

	GameUI.SetCameraTargetPosition([map_relative_x * 1.055 * map_size - map_size / 2, -map_relative_y * 1.055 * map_size + map_size / 2, 0], 0.15)

	//GameEvents.SendCustomGameEventToServer("MinimapMove", {x: map_relative_x * 1.055, y: map_relative_y * 1.055})
}
function right_click_minimap() {
	var cursor_x = GameUI.GetCursorPosition()[0]
	var cursor_y = GameUI.GetCursorPosition()[1]

	var map_relative_x = Math.min(Math.max((cursor_x - getXOffset($("#MinimapPanel"))) / $("#MinimapPanel").actuallayoutwidth, MIN_X), MAX_X)
	var map_relative_y = Math.min(Math.max((cursor_y - getYOffset($("#MinimapPanel"))) / $("#MinimapPanel").actuallayoutheight, MIN_Y), MAX_Y)

	var new_pos = [map_relative_x * map_size - map_size / 2, -map_relative_y * map_size + map_size / 2, 150]

	var pid = Particles.CreateParticle("particles/ui_mouseactions/clicked_basemove.vpcf", ParticleAttachment_t.PATTACH_CUSTOMORIGIN, 0)
	Particles.SetParticleControl(pid, 0, new_pos); 
	Particles.SetParticleControl(pid, 1, [0, 255, 0]); 

	GameEvents.SendCustomGameEventToServer("MinimapMovePlayer", {x: map_relative_x * 1.055, y: map_relative_y * 1.055})
}

var is_in_minimap = false;

function on_mouse_over() {
	is_in_minimap = true;
}

function on_mouse_out() {
	is_in_minimap = false;
}

var left_click_tracker = false
var right_click_tracker = false

var is_left_clicking_outside_minimap = false;

function update_minimap() {
	$.Schedule(0.01, update_minimap)
	if(GameUI.IsMouseDown(0)) {
		if(is_in_minimap && !is_left_clicking_outside_minimap) {
			click_minimap()
		} else {
			is_left_clicking_outside_minimap = true;
		}
		if(!left_click_tracker) {
			
		}
		left_click_tracker = true
	} else {
		left_click_tracker = false;
		is_left_clicking_outside_minimap = false;
	}
	if(GameUI.IsMouseDown(1)) {
		if(!right_click_tracker) {
			if(is_in_minimap) {
				right_click_minimap()
			}
		}
		right_click_tracker = true
	} else {
		right_click_tracker = false;
	}

	var camera_pos = Game.ScreenXYToWorld(Game.GetScreenWidth() / 2, Game.GetScreenHeight() / 2)
	var relative_camera_x = Math.max(Math.min((camera_pos[0] + map_size / 2) / map_size, MAX_X), MIN_X)
	var relative_camera_y = Math.max(Math.min((camera_pos[1] + map_size / 2) / map_size, MAX_Y), MIN_Y)
	$("#MinimapCamera").style.marginLeft = (relative_camera_x * 100 - 10) + "%";
	$("#MinimapCamera").style.marginTop = 100 - (relative_camera_y * 100 + 7) + "%";

	while ($("#MinimapUnits").GetChildCount() < units_length) {
		var minimap_unit_panel = $.CreatePanel("Image", $("#MinimapUnits"), "MinimapHero")
		$.CreatePanel("Image", minimap_unit_panel, "MinimapHeroImage")
	}
	for (var i = 0; i < $("#MinimapUnits").GetChildCount() ; i++) {
		$("#MinimapUnits").GetChild(i).style.opacity = "0"
	}
	for(var index in units) {
		var minimap_unit = units[index]
		var minimap_unit_panel = $("#MinimapUnits").GetChild(index - 1)

		var size = 20
		var is_binding = false
		var color =""
		if(minimap_unit.team == 2) {
			color = "_blue"
		}
		if(minimap_unit.team == 3) {
			color = "_red"
		}
		if(minimap_unit.type != null) {
			if(minimap_unit.type == "creep") {
				size = 3
			}
			if(minimap_unit.type == "binding") {
				size = 8
				is_binding = true
			}
		}

		minimap_unit_panel.style.width = size + "%"
		minimap_unit_panel.style.height = size + "%"
		minimap_unit_panel.style.opacity = "1"
		minimap_unit_panel.style.marginLeft = (parseFloat(minimap_unit.pos.split(" ")[0]) + map_size / 2) / map_size * 100 - size / 2 + "%"
		minimap_unit_panel.style.marginTop = 100 - (parseFloat(minimap_unit.pos.split(" ")[1]) + map_size / 2) / map_size * 100 - size / 2 + "%"
		if(!is_binding) {
			minimap_unit_panel.SetImage("file://{images}/custom_game/minimap_arrow" + color + ".png")
			minimap_unit_panel.style.transform = "rotateZ( " + (-minimap_unit.angle) + "deg )"
			minimap_unit_panel.GetChild(0).SetImage("file://{images}/heroes/icons/" + minimap_unit.name + ".png")
			minimap_unit_panel.GetChild(0).style.transform = "rotateZ( " + (minimap_unit.angle) + "deg )"
		} else {
			minimap_unit_panel.SetImage("file://{images}/custom_game/minimap_tower" + color + ".png")
			minimap_unit_panel.style.transform = "rotateZ( 0deg )"
			minimap_unit_panel.GetChild(0).SetImage(null)
			minimap_unit_panel.GetChild(0).style.transform = "rotateZ( 0deg )"
		}
	}
}
$.Schedule(0.01, update_minimap)

GameEvents.Subscribe("MinimapCameraDummyUnitPositionUpdate", function(event) {
	local_pid = Players.GetLocalPlayer();
	local_entity = Players.GetPlayerHeroEntityIndex(local_pid);

	GameUI.SetCameraTarget(event.id)

	$.Schedule(0.1, function() {
		GameUI.SetCameraTarget(-1)
	})
})

var units = {}
var units_length = 0

GameEvents.Subscribe("MinimapUpdateUnits", function(event) {
	units = event.units
	units_length = event.length
})