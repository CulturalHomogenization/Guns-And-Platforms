class_name State
extends Node

#once again this is the "default template" for each state. this declares the class name state and
#each state extends from this

@export var animation_name: String 
@export var move_speed: float = 400

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var parent: Player

func enter() -> void:
	owner.animations.play(animation_name)

func exit() -> void:
	pass

func process_input(_event: InputEvent) -> State:
	return null

func process_frame(_event: float) -> State:
	return null

func process_physics(_event: float) -> State:
	return null
