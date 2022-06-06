tool
extends Sprite

export (bool) var turned_on = true setget set_turned_on

const on_texture = preload("res://map/light_fixture.png")
const off_texture = preload("res://map/light_fixture_off.png")

func set_turned_on(is_turned_on):
	turned_on = is_turned_on
	if turned_on:
		texture = on_texture
	else:
		texture = off_texture
	for child in get_children():
		child.visible = turned_on

func _ready():
	for child in get_children():
		child.rotation = rand_range(0, 2*PI)
