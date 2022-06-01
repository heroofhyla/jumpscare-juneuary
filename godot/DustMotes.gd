extends ParallaxLayer

export (float) var y_drift
func _physics_process(delta):
	motion_offset += Vector2(0, y_drift) * delta
