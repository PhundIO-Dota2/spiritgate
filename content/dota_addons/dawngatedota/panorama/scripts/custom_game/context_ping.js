var context_menu_origin_x = 0
var context_menu_origin_y = 0
var current_context_menu_selection = null

function tick_ping_menu() {
	if($("#ContextPingMenu") == null) {
		$.CreatePanel("Panel", $.GetContextPanel(), "ContextPingMenu")
		$.CreatePanel("Image", $("#ContextPingMenu"), "ContextPingMenuImage")
		$.CreatePanel("Image", $("#ContextPingMenuImage"), "ContextPingSelectionImage")

		$.CreatePanel("Label", $("#ContextPingMenuImage"), "ContextPingLabelRetreat")
		$.CreatePanel("Label", $("#ContextPingMenuImage"), "ContextPingLabelAttention")
		$.CreatePanel("Label", $("#ContextPingMenuImage"), "ContextPingLabelMissing")
		$.CreatePanel("Label", $("#ContextPingMenuImage"), "ContextPingLabelOnMyWay")
		$.CreatePanel("Label", $("#ContextPingMenuImage"), "ContextPingLabelDanger")
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

	var label = $("#ContextPingLabelRetreat")
	label.style.color = "#EEEEEE"
	label.style.marginLeft = "13%"
	label.style.marginTop = "75%"
	label.style.fontWeight = "bold";
	label.style.fontSize = "24px;"
	label.style.textShadow = "0px 0px 4px #000000"
	label.text = "Retreat"

	label = $("#ContextPingLabelAttention")
	label.style.color = "#EEEEEE"
	label.style.marginLeft = "5%"
	label.style.marginTop = "37%"
	label.style.fontWeight = "bold";
	label.style.fontSize = "24px;"
	label.style.textShadow = "0px 0px 4px #000000"
	label.text = "Attention"

	label = $("#ContextPingLabelMissing")
	label.style.color = "#EEEEEE"
	label.style.marginLeft = "55%"
	label.style.marginTop = "75%"
	label.style.fontWeight = "bold";
	label.style.fontSize = "24px;"
	label.style.textShadow = "0px 0px 4px #000000"
	label.text = "Missing"

	label = $("#ContextPingLabelOnMyWay")
	label.style.color = "#EEEEEE"
	label.style.marginLeft = "59%"
	label.style.marginTop = "40%"
	label.style.fontWeight = "bold";
	label.style.fontSize = "20px;"
	label.style.textShadow = "0px 0px 4px #000000"
	label.text = "On My Way"

	label = $("#ContextPingLabelDanger")
	label.style.color = "#EEEEEE"
	label.style.marginLeft = "34.5%"
	label.style.marginTop = "10%"
	label.style.fontWeight = "bold";
	label.style.fontSize = "24px;"
	label.style.textShadow = "0px 0px 4px #000000"
	label.text = "Danger"

	if(GameUI.IsMouseDown(0) && GameUI.IsAltDown()) {
		$.Schedule(0.01, tick_ping_menu)
	} else {
		if(current_context_menu_selection != null) {
			GameUI.PingMinimapAtLocation(GameUI.GetScreenWorldPosition([context_menu_origin_x, context_menu_origin_y]))
			var message = ""
			if(current_context_menu_selection == 3) {
				message = "Retreat!"
			}
			if(current_context_menu_selection == 4) {
				message = "Attention Over here!"
			}
			if(current_context_menu_selection == 5) {
				message = "Danger!"
			}
			if(current_context_menu_selection == 1) {
				message = "On my way!"
			}
			if(current_context_menu_selection == 2) {
				message = "Enemy Missing!"
			}
			GameEvents.SendCustomGameEventToServer("SpiritgateChat", { text: message })
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
	if (distance > inner_limit) {
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