extends KinematicBody2D

onready var flashlight = $FlashlightSpot
#onready var flashlight = $Body/Arm/FlashlightBeam
onready var arm = $Body/Arm
onready var hand = $Body/Arm/Hand
onready var elbow = $Body/Elbow
#onready var flashlight_target = $FlashlightTarget
onready var original_flashlight_length = hand.position.distance_to(flashlight.position)

var velocity = Vector2.ZERO
var max_speed = 200

var facing = 1
var right_camera_position = Vector2(-90, -464)
var left_camera_position = Vector2(-1190,-465)
var right_mouse_bounds = Rect2(117,-340, 916,460)
var left_mouse_bounds = Rect2(-1280 + 364 - 117, -340, 916, 460)
var mouse_bounds = right_mouse_bounds
var sprite_right = load("res://player/test_player.png")
var sprite_left = load("res://player/test_player_left.png")

func _ready():
	var verts = PoolVector2Array()
	verts.push_back(Vector2(0,0))
	verts.push_back(Vector2(100,0))
	verts.push_back(Vector2(0,100))
	var mesh = ArrayMesh.new()
	var arr = []
	arr.resize(ArrayMesh.ARRAY_MAX)
	arr[ArrayMesh.ARRAY_VERTEX] = verts
	mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES, arr)
	#var mesh_instance = MeshInstance2D.new()
	#mesh_instance.mesh = mesh
	
func _input(event):
	if event.is_action_pressed("turn"):
		facing = 1 - facing
	
		if facing == 1:
			#$Body.scale.x = 1
			$PlayerCamera.position = right_camera_position
			$LightBeam.position = $PlayerCamera.position
			mouse_bounds = right_mouse_bounds
			$Body.texture = sprite_right
			$Body/Arm.position.x -= 32
		else:
			#$Body.scale.x = -1
			$PlayerCamera.position = left_camera_position
			$LightBeam.position = $PlayerCamera.position
			mouse_bounds = left_mouse_bounds
			$Body.texture = sprite_left
			$Body/Arm.position.x += 32
		$FlashlightSpot.position.x *= -1
		update_flashlight()

	if event is InputEventMouseMotion:
		var rel = event.relative
		#flashlight_target.position += rel
		flashlight.position += rel
		update_flashlight()

func update_flashlight():
		var flashlight_length = hand.position.distance_to(flashlight.position)
		var length_ratio = flashlight_length/original_flashlight_length
		arm.rotation = elbow.global_position.direction_to(flashlight.global_position).angle()
		flashlight.position.x = clamp(flashlight.position.x, mouse_bounds.position.x,mouse_bounds.end.x)
		flashlight.position.y = clamp(flashlight.position.y, mouse_bounds.position.y, mouse_bounds.end.y)
		flashlight.scale.x = length_ratio/4 + .5
		flashlight.scale.y = length_ratio/8 + .5
		flashlight.rotation = hand.global_position.direction_to(flashlight.global_position).angle()
		flashlight.modulate.a = (2.5 - flashlight.scale.x) / 2
func _physics_process(delta):
	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = x_input * max_speed
	velocity = move_and_slide(velocity)
