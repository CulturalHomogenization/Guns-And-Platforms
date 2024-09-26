class_name Boss_State
extends Node
#This is essencially the base template of all states of the boss state machine.
# it defines the class name as Boss_State and all subsiquent states extends this class.
# this is why each of the states if you click on them in the editor will require an animation name and a move speed. 
@export var animation_name: String
@export var move_speed: float = 100

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var parent: Boss

func enter() -> void:
	owner.animations.play(animation_name)

func exit() -> void:
	pass

func process_input(event: InputEvent) -> Boss_State:
	return null #each function returns no state by default

func process_frame(event: float) -> Boss_State:
	return null #each function returns no state by default

func process_physics(event: float) -> Boss_State:
	return null #each function returns no state by default
