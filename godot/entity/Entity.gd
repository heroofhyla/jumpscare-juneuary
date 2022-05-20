class_name Entity

extends KinematicBody2D

var state = null


func handle_state(new_state:EntityState):
	if not new_state:
		return
	if new_state.timeout_delay <= 0:
		print("found state with wait time less than zero")
		print(name)
		print(new_state.display_name)
	if new_state:
		if state:
			state.queue_free()
		state = new_state
		add_child(state)
		start_timer()
		handle_state(state.enter())


func _ready():
	$StateTimer.connect("timeout", self, "_on_StateTimer_timeout")
	$AnimationPlayer.connect("animation_finished", self, "_on_animation_finished")
	$Tween.connect("tween_all_completed", self, "_on_tween_all_completed")
	setup()


func setup():
	handle_state(IdleState.new(self))


func start_timer():
	$StateTimer.wait_time = state.timeout_delay
	$StateTimer.start($StateTimer.wait_time)


func _physics_process(delta):
	handle_state(state.physics_process(delta))


func _process(delta):
	handle_state(state.process(delta))


func _on_StateTimer_timeout():
	handle_state(state.timeout())


func _on_animation_finished(_anim):
	handle_state(state.animation_over())


func _input(event):
	handle_state(state.input(event))


func _on_tween_all_completed():
	handle_state(state.tween_all_completed())


class IdleState extends EntityState:
	func _init(entity).(entity):
		self.display_name = "IdleState"
		pass
