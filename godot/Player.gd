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
	if event is InputEventMouseMotion:
		var rel = event.relative
		#flashlight_target.position += rel
		flashlight.position += rel
		var flashlight_length = hand.position.distance_to(flashlight.position)
		var length_ratio = flashlight_length/original_flashlight_length
		arm.rotation = elbow.global_position.direction_to(flashlight.global_position).angle()
		flashlight.position.x = clamp(flashlight.position.x, 117,1033)
		flashlight.position.y = clamp(flashlight.position.y, -340,120)
		flashlight.scale.x = length_ratio/4 + .5
		flashlight.scale.y = length_ratio/8 + .5
		flashlight.rotation = hand.global_position.direction_to(flashlight.global_position).angle()
		flashlight.modulate.a = (2.5 - flashlight.scale.x) / 2


func _physics_process(delta):
	var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.x = x_input * max_speed
	velocity = move_and_slide(velocity)
