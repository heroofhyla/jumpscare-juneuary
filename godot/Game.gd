extends Node2D

var mouse_vis = false
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#Engine.time_scale = 0.125

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if mouse_vis:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			mouse_vis = false
			return
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		mouse_vis = true
