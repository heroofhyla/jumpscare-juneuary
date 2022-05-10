extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.


func _draw():
	draw_polygon(PoolVector2Array([Vector2(100,100), Vector2(100,200), Vector2(200,100)]),PoolColorArray([Color.red, Color.red, Color.red]))
