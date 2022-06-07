extends CanvasLayer

var mouse_vis = false

func flashlight_mode():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	mouse_vis = false

func cursor_mode():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	mouse_vis = true

func show_messages(messages):
	$TextPane.set_messages(messages)
	$TextPane.show()
	cursor_mode()
	Game.state = Game.STATE_CUTSCENE
	yield($TextPane, "messages_done")
	$TextPane.hide()
	flashlight_mode()
	Game.state = Game.STATE_EXPLORE
