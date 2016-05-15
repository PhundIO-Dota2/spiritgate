var ping_just_used = false
function UpdatePing() {
	if(GameUI.IsMouseDown(0)) {
		if(!ping_just_used && GameUI.IsControlDown()) {
			$.Msg(GameUI.GetCursorPosition())
		}
		ping_just_used = true;
	} else {
		ping_just_used = false;
	}
	$.Schedule(0.03, UpdatePing)
}
$.Schedule(0.03, UpdatePing)