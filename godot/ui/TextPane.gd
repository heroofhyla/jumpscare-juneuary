extends ColorRect

onready var text_label = get_node("TextMargin/Text")
onready var tween = get_node("Tween")
var showing = true

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

func set_text(text):
	text_label.txt = text

func show():
	if showing:
		return
	print("showing")
	tween.interpolate_property(self, "rect_position", hide_position, show_position, 0.5)
	tween.start()
	showing = true

func hide():
	if not showing:
		return
	print("hiding")
	tween.interpolate_property(self, "rect_position", show_position, hide_position, 0.5)
	tween.start()
	showing = false

func _player_turning(new_direction):
	hide()
	show_position = show_positions[new_direction]
	hide_position = hide_positions[new_direction]
