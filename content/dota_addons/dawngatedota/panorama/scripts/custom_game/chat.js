function OnChatSubmitted() {
	GameEvents.SendCustomGameEventToServer("SpiritgateChat", {text: $("#ChatEntry").text})
	$("#ChatEntry").text = ""
}

function FadeMessage(message) {
	$.Schedule(2, function() {
		var opacity = 1
		function disappearText() {
			if(opacity > 0) {
				opacity -= 0.06;
				$.Schedule(0.03, disappearText)
			} else {
				message.DeleteAsync(0)
			}
			message.style.opacity = opacity
		}
		disappearText()
	})
}

GameEvents.Subscribe("SpiritgateChat", function(event) {
	var messages = $("#ChatMessages")
	var message = $.CreatePanel("Panel", messages, "ChatMessage")
	var message_text = $.CreatePanel("Label", message, "ChatMessageLabel")
	message_text.text = "        " + event.text + "   "
	FadeMessage(message)
})

GameEvents.Subscribe("SpiritgateHeroKill", function(event) {
	var messages = $("#ChatMessages")
	var message = $.CreatePanel("Panel", messages, "ChatMessage")
	message.AddClass("flow-right")
	var message_text_1 = $.CreatePanel("Label", message, "ChatMessageLabel1")
	var message_image = $.CreatePanel("Image", message, "ChatMessageImage")
	var message_text_2 = $.CreatePanel("Label", message, "ChatMessageLabel2")
	var message_part_1 = ""
	if(event.killer_is_hero) {
		message_part_1 = Players.GetPlayerName(event.killer)
	} else {
		message_part_1 = event.killer
	}
	message_text_1.text = "        " + message_part_1 + "  "

	var message_part_2 = Players.GetPlayerName(event.dead_hero)
	message_text_2.text = " " + message_part_2 + "  "

	message_image.SetImage("file://{images}/custom_game/kill_skull.png")
	message_image.style.height = "100%"
	message_image.style.width = "height-percentage(100%)"

	FadeMessage(message)
})

