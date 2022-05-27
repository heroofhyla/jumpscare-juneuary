class_name EntityState
extends Node

var _entity = null
var timeout_delay = 1.0
var display_name = "EntityState"

func _init(entity):
	_entity = entity


func enter() -> EntityState:
	return null


func process(delta:float) -> EntityState:
	return null


func physics_process(delta:float) -> EntityState:
	return null


func timeout() -> EntityState:
	return null


func cutscene_over() -> EntityState:
	return null


func input(event) -> EntityState:
	return null


func animation_finished() -> EntityState:
	return null


func tween_all_completed() -> EntityState:
	return null


func animation_over() -> EntityState:
	return null
