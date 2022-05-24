extends Entity

const max_speed = 200
var velocity = Vector2.ZERO

onready var flashlight = $FlashlightSpot
#onready var flashlight = $Body/Arm/FlashlightBeam
onready var arm = $Body/Arm
onready var hand = $Body/Arm/Hand
onready var elbow = $Body/Elbow
onready var light_top = $FlashlightSpot/LightTop
onready var light_bottom = $FlashlightSpot/LightBottom
#onready var flashlight_target = $FlashlightTarge
var facing = 1

onready var original_flashlight_length = hand.position.distance_to(flashlight.position)
var right_camera_position = Vector2(-90, -464)
var left_camera_position = Vector2(-1190,-465)
var right_mouse_bounds = Rect2(117,-340, 916,460)
var left_mouse_bounds = Rect2(-1280 + 364 - 117, -340, 916, 460)
var mouse_bounds = right_mouse_bounds
func setup():
	.setup()
	handle_state(ExploreState.new(self))


func update_flashlight(limit=true, update_arm=true):
		var flashlight_length = hand.position.distance_to(flashlight.position)
		var length_ratio = flashlight_length/original_flashlight_length
		arm.rotation = elbow.global_position.direction_to(flashlight.global_position).angle()
		if facing == 0:
			arm.rotation = PI - arm.rotation
		if limit:
			flashlight.position.x = clamp(flashlight.position.x, mouse_bounds.position.x,mouse_bounds.end.x)
			flashlight.position.y = clamp(flashlight.position.y, mouse_bounds.position.y, mouse_bounds.end.y)
		flashlight.scale.x = length_ratio/4 + .5
		flashlight.scale.y = length_ratio/8 + .5
		if facing == 0:
			flashlight.scale.y *= -1
		flashlight.rotation = hand.global_position.direction_to(flashlight.global_position).angle()
		if light_top.global_position.y > light_bottom.global_position.y:
			flashlight.scale.y *= -1
		flashlight.modulate.a = (2.5 - flashlight.scale.x) / 2


# Default "stand and walk and look around" state. Player is in full control.
class ExploreState extends EntityState:
	func _init(entity).(entity):
		pass
	
	func enter():
		var body:Sprite = _entity.get_node("Body")
		if _entity.facing == 1:
			body.scale.x = 1
		else:
			body.scale.x = -1
	func input(event):
		if event is InputEventMouseMotion:
			var rel = event.relative
			_entity.flashlight.position += rel
			_entity.update_flashlight()
			return

		if event.is_action_pressed("turn"):
			return TurningState.new(_entity)

	func physics_process(delta):
		var x_input = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
		_entity.velocity.x = x_input * _entity.max_speed
		_entity.velocity = _entity.move_and_slide(_entity.velocity)
	  

class TurningState extends EntityState:
	var tween:Tween
	var camera:Camera2D
	var flashlight_spot:Light2D
	var original_facing:int
	var tween_progress:float
	var body:Sprite
	func _init(entity).(entity):
		tween = _entity.get_node("Tween")
		camera = _entity.get_node("PlayerCamera")
		flashlight_spot = _entity.get_node("FlashlightSpot")
		original_facing = _entity.facing
		body = _entity.get_node("Body")
		pass
	
	func enter():
		var tween_speed = 0.75
		if _entity.facing == 1:
			tween.interpolate_property(camera, "position", camera.position, _entity.left_camera_position, tween_speed)
		else:
			tween.interpolate_property(camera, "position", camera.position, _entity.right_camera_position, tween_speed)
		tween.interpolate_property(flashlight_spot, "position", flashlight_spot.position, flashlight_spot.position * Vector2(-1,1), tween_speed)
		tween.interpolate_property(self, "tween_progress", 0.0, 1.0, tween_speed)
		tween.start()
	
	func physics_process(delta):
		if tween_progress >= 0.5:
			_entity.facing = 1 - original_facing
		else:
			_entity.facing = original_facing

		if _entity.facing == 1:
			_entity.mouse_bounds = _entity.right_mouse_bounds
			body.scale.x = 1
		else:
			_entity.mouse_bounds = _entity.left_mouse_bounds
			body.scale.x = -1
		_entity.update_flashlight(false)

	func tween_all_completed():
		return ExploreState.new(_entity)