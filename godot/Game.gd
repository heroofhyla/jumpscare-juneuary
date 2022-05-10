extends Node2D

var mouse_vis = false
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		var rel = event.relative
		$TestPlayer/FlashlightSpot.position += rel
		$TestPlayer/Arm.rotation = $TestPlayer/Elbow.global_position.direction_to($TestPlayer/FlashlightSpot.global_position).angle()
		$TestPlayer/FlashlightSpot.position.x = clamp($TestPlayer/FlashlightSpot.position.x, 117,1033)
		$TestPlayer/FlashlightSpot.position.y = clamp($TestPlayer/FlashlightSpot.position.y, -340,120)
		$TestPlayer/FlashlightSpot.scale.x = $TestPlayer/Arm/Hand.global_position.distance_to($TestPlayer/FlashlightSpot.global_position) / 640 + .5
		$TestPlayer/FlashlightSpot.scale.y = $TestPlayer/Arm/Hand.global_position.distance_to($TestPlayer/FlashlightSpot.global_position) / 1280 + .5
		$TestPlayer/FlashlightSpot.rotation = $TestPlayer/Arm/Hand.global_position.direction_to($TestPlayer/FlashlightSpot.global_position).angle()
		$TestPlayer/FlashlightSpot.modulate.a = (2.5 - $TestPlayer/FlashlightSpot.scale.x) / 2

	if event.is_action_pressed("ui_cancel"):
		if mouse_vis:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			mouse_vis = false
			return
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		mouse_vis = true
