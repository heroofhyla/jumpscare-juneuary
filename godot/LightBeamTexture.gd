extends Sprite

onready var light_top = get_node("../../Player/FlashlightSpot/LightTop")
onready var light_bottom = get_node("../../Player/FlashlightSpot/LightBottom")
onready var hand_top = get_node("../../Player/Body/Arm/HandTop")
onready var hand_bottom = get_node("../../Player/Body/Arm/HandBottom")
onready var player = get_node("../../Player")
var printed = false
var colors = [
	Color.white,
	Color.white,
	Color.white,
	Color.white
	]

func build_point(point):
	return Vector2(
		point.global_position.x - global_position.x,
		720 - (point.global_position.y - global_position.y)
	)
func _draw():
	var verts = [
		build_point(light_top),
		build_point(light_bottom),
		build_point(hand_bottom),
		build_point(hand_top)
		]
	
	if not printed:
		for vert in verts:
			print(str(vert))
		printed = true
	draw_polygon(PoolVector2Array(verts), PoolColorArray(colors))

func _process(delta):
	update()
