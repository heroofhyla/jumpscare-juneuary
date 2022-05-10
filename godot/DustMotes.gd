extends ParallaxLayer

func _physics_process(delta):
	motion_offset += Vector2(0, -5) * delta
