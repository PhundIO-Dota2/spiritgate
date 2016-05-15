function OnChatSubmitted() {
	GameEvents.SendCustomGameEventToServer("SpiritgateChat", {text: $("#ChatEntry").text})
	$("#ChatEntry").text = ""
}

GameEvents.Subscribe("SpiritgateChat", function(event) {
	var messages = $("#ChatMessages")
	var message = $.CreatePanel("Panel", messages, "ChatMessage")
	var message_text = $.CreatePanel("Label", message, "ChatMessageLabel")
	message_text.text = "              " + event.text + "    "
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
})