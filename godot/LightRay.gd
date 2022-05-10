extends Sprite

func _draw():
	var points = [
		Vector2($LightBottom.position.x, 720 - $LightBottom.position.y),
		Vector2($HandBottom.position.x, 720 - $HandBottom.position.y),
		Vector2($HandTop.position.x, 720 - $HandTop.position.y),
		Vector2($LightTop.position.x, 720 - $LightTop.position.y)
		]
	draw_polygon(PoolVector2Array(points), PoolColorArray([Color.white, Color.white, Color.white, Color.white]))

func _process(delta):
	update()
