extends ColorRect

onready var text_label = get_node("TextMargin/Text")
onready var tween = get_node("Tween")
var showing = false
var message_queue = []
signal messages_done

var show_positions = [
	Vector2(0,0),
	Vector2(1280-480,0)
]

var hide_positions = [
	Vector2(-480, 0),
	Vector2(1280,0)
]
var show_position = Vector2(1280-480,0)
var hide_position = Vector2(1280,0)

func _ready():
	EventBus.connect("player_turning", self, "_player_turning")
	$Button.connect("pressed", self, "_button_pressed")
	rect_position = hide_position

func set_text(text):
	text_label.text = text

func set_messages(messages):
	message_queue = messages
	set_text(message_queue.pop_front())

func show():
	if showing:
		return
	tween.interpolate_property(self, "rect_position", hide_position, show_position, 0.5)
	tween.start()
	showing = true
	Game.state = Game.STATE_CUTSCENE

func hide():
	if not showing:
		return
	tween.interpolate_property(self, "rect_position", show_position, hide_position, 0.5)
	tween.start()
	showing = false
	Game.state = Game.STATE_EXPLORE

func _player_turning(new_direction):
	hide()
	show_position = show_positions[new_direction]
	hide_position = hide_positions[new_direction]

func _button_pressed():
	if message_queue:
		set_text(message_queue.pop_front())
	else:
		emit_signal("messages_done")
