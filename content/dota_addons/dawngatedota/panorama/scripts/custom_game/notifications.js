var notification_panel = $.CreatePanel("Panel", $.GetContextPanel(), "NotificationPanel")
notification_panel.style.width = "100%"
notification_panel.style.height = "100%"
notification_panel.hittest = false
var notification_label_bottom = $.CreatePanel("Label", notification_panel, "NotificationLabelBottom")

var current_notification_id = 0

function ShowScreenNotification(text) {
	current_notification_id++
	var this_notification_id = current_notification_id
	notification_label_bottom.text = ""

	notification_label_bottom.RemoveClass('notification-anim')
	$.Schedule(0.03, function() {
		notification_label_bottom.AddClass('notification-anim')

		notification_label_bottom.style.color = "#CC0000"
		notification_label_bottom.style.fontSize = "37px"
		notification_label_bottom.style.textAlign = "center"
		notification_label_bottom.style.marginTop = "67.5%"
		notification_label_bottom.style.width = "100%"
		notification_label_bottom.style.textShadow = "2px 2px 2px #000000"
		notification_label_bottom.hittest = false

		notification_label_bottom.text = $.Localize(text)

		$.Schedule(2, function() {
			if(current_notification_id == this_notification_id) {
				notification_label_bottom.text = ""
			}
		})
	})
}
