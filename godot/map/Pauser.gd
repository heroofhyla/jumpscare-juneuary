extends Node2D

func _input(event):
	if event.is_action_pressed("debug_2"):
		get_tree().paused = not get_tree().paused
