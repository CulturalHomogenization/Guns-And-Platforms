class_name State
extends Node

@export var animation_name: String
@export var move_speed: float = 400

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var parent: Boss

func enter() -> void:
	owner.animations.play(animation_name)

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(event: float) -> State:
	return null

func process_physics(event: float) -> State:
	return null
