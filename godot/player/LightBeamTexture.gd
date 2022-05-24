extends Sprite

export (NodePath) var player_camera_path
export (NodePath) var light_top_path
export (NodePath) var light_end_path
export (NodePath) var light_bottom_path
export (NodePath) var hand_top_path
export (NodePath) var hand_bottom_path
export (NodePath) var player_path
export (bool) var flip_y = true
export (bool) var polyline = false
var light_top
var light_end
var light_bottom
var hand_top
var hand_bottom
var player_camera
var player
var verts = []

const translucent_white = Color(1,1,1,0.3)


func _ready():
	player_camera = get_node(player_camera_path)
	light_top = get_node(light_top_path)
	light_end = get_node(light_end_path)
	light_bottom = get_node(light_bottom_path)
	hand_top = get_node(hand_top_path)
	hand_bottom = get_node(hand_bottom_path)
	player = get_node(player_path)
	#material.set_shader_param("ViewportTexture", get_parent().get_texture())

func build_point(point):
	if flip_y:
		return Vector2(
			point.global_position.x - player_camera.global_position.x,
			720 - (point.global_position.y - player_camera.global_position.y)
		)
	else:
		return Vector2(
			point.global_position.x - player_camera.global_position.x,
			(point.global_position.y - player_camera.global_position.y)
		)

func shrink_verts(verts):
	verts[0].x -= 4
	verts[0].y -= 4
	verts[1].x -= 4
	verts[1].y -= 0
	verts[2].x -= 4
	verts[2].y += 4
	verts[3].x += 4
	verts[3].y += 4
	verts[4].x += 4
	verts[4].y -= 4

func clean_up_duplcates(arr):
	for i in range(len(arr - 1)):
		if arr[i] in arr.slice(i, len(arr)):
			print("duplicate found!")

func _draw():

	verts = [
		build_point(light_top),
		build_point(light_end),
		build_point(light_bottom),
		build_point(hand_bottom),
		build_point(hand_top)
		]

	
	#if player.facing == 1 and verts[0].x < verts[4].x:
		#return
	#if player.facing == 0 and verts[0].x > verts[4].x:
		#return
	if polyline:
		draw_polyline(PoolVector2Array(verts), Color.red)
	else:
		draw_colored_polygon(PoolVector2Array(verts), Color.white)
	
	#shrink_verts(verts)
	#draw_colored_polygon(PoolVector2Array(verts), translucent_white)
	#shrink_verts(verts)
	#draw_colored_polygon(PoolVector2Array(verts), translucent_white)
	
func _physics_process(delta):
	update()
	if Input.is_action_just_pressed("debug_1"):
		print("===")
		for vert in verts:
			print(str(vert))
