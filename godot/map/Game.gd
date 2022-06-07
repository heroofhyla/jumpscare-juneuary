extends Node2D

var mouse_vis = false
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#Engine.time_scale = 0.125
	AudioManager.play_music("exploring")

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if mouse_vis:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			mouse_vis = false
			return
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		mouse_vis = true

	if event.is_action_pressed("debug_1"):
		UI.show_messages([
			"""And so this is Christmas.
			
			And what have you done?
			
			Another year older.
			
			A new one just begun.""",
			
			"""And so this is Christmas.
			
			I hope you have fun.
			
			The near and the dear ones.
			
			The old and the young."""
			])
