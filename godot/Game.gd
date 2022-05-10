extends Node2D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		var rel = event.relative
		$FlashlightSpot.position += rel
		$FlashlightSpot.position.x = clamp($FlashlightSpot.position.x, 217,1133)
		$FlashlightSpot.scale.x = $TestPlayer/Hand.global_position.distance_to($FlashlightSpot.global_position) / 640 + .5
		$FlashlightSpot.scale.y = $TestPlayer/Hand.global_position.distance_to($FlashlightSpot.global_position) / 1280 + .5
		$FlashlightSpot.rotation = $TestPlayer/Hand.global_position.direction_to($FlashlightSpot.global_position).angle()
		$AngleLabel.text = str($FlashlightSpot.rotation)

	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
