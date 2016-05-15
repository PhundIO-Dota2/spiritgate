var context_menu_origin_x = 0
var context_menu_origin_y = 0
var current_context_menu_selection = null

function tick_ping_menu() {
	if($("#ContextPingMenu") == null){
		$.CreatePanel("Panel", $.GetContextPanel(), "ContextPingMenu")
		$.CreatePanel("Image", $("#ContextPingMenu"), "ContextPingMenuImage")
		$.CreatePanel("Image", $("#ContextPingMenuImage"), "ContextPingSelectionImage")
	}
	var context_menu = $("#ContextPingMenu")
	var context_menu_size = 25
	context_menu.style.opacity = 1
	context_menu.style.height = context_menu_size + "%;"
	context_menu.style.width = context_menu_size + "%;"
	var context_menu_image = $("#ContextPingMenuImage")
	context_menu_image.SetImage("file://{images}/custom_game/context_ping_menu.png")
	context_menu_image.style.height = "100%"
	context_menu_image.style.width = "height-percentage(100%)"
	context_menu_image.style.horizontalAlign = "center"

	if(GameUI.IsMouseDown(0) && GameUI.IsAltDown()) {
		$.Schedule(0.01, tick_ping_menu)
	} else {
		if(current_context_menu_selection != null) {
			GameUI.PingMinimapAtLocation(GameUI.GetScreenWorldPosition([context_menu_origin_x, context_menu_origin_y]))
		}
		current_context_menu_selection = null
		context_menu.style.opacity = 0
		return
	}
	
	var cursor_relative_position_x = context_menu_origin_x / Game.GetScreenWidth()
	var cursor_relative_position_y = context_menu_origin_y / Game.GetScreenHeight()
	context_menu.style.marginLeft = (cursor_relative_position_x * 100 - context_menu_size / 2) + "%"
	context_menu.style.marginTop = (cursor_relative_position_y * 100 - context_menu_size / 2) - 2 + "%"

	cursor_x = GameUI.GetCursorPosition()[0]
	cursor_y = GameUI.GetCursorPosition()[1]

	var context_menu_selection_image = $("#ContextPingSelectionImage")
	current_context_menu_selection = null
	context_menu_selection_image.style.opacity = 0
	context_menu_selection_image.AddClass("fill")
	context_menu_selection_image.SetImage("file://{images}/custom_game/context_ping_menu_selection.png")

	var angle = Math.atan2(cursor_y - context_menu_origin_y, cursor_x - context_menu_origin_x) * 180 / 3.1415
	var distance = Math.sqrt((cursor_y - context_menu_origin_y) * (cursor_y - context_menu_origin_y) + (cursor_x - context_menu_origin_x) * (cursor_x - context_menu_origin_x)) / ((Game.GetScreenWidth() + Game.GetScreenHeight()) / 2)
	
	var inner_limit = 0.014
	var outer_limit = 0.15
	if (distance > inner_limit && distance < outer_limit) {
		context_menu_selection_image.style.opacity = 1
		if(angle < 23 && angle > -50) {
			context_menu_selection_image.style.transform = "rotateZ(" + -74 + "deg)"
			current_context_menu_selection = 1
		} else if (angle < 89 && angle >= 23) {
			context_menu_selection_image.style.transform = "rotateZ(" + 0 + "deg)"
			current_context_menu_selection = 2
		} else if (angle < 160 && angle >= 89) {
			context_menu_selection_image.style.transform = "rotateZ(" + 72 + "deg)"
			current_context_menu_selection = 3
		} else if (angle > 160 ||angle < -130) {
			context_menu_selection_image.style.transform = "rotateZ(" + 144 + "deg)"
			current_context_menu_selection = 4
		} else {
			context_menu_selection_image.style.transform = "rotateZ(" + (144 + 70) + "deg)"
			current_context_menu_selection = 5
		}
	}
}

GameUI.SetMouseCallback(function(event, button) {
	if(event == "pressed" && button == 0 && GameUI.IsAltDown()) {
		context_menu_origin_x = GameUI.GetCursorPosition()[0]
		context_menu_origin_y = GameUI.GetCursorPosition()[1]
		tick_ping_menu()
		return true
	}
})