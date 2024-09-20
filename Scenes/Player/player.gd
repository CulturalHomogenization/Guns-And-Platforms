class_name Player
extends CharacterBody2D

@onready var animations = $animations
@onready var state_machine = $state_machine
@export var hurt_state : State
var invinsible : bool = false
@onready var invinsibility: Timer = $Invinsibility

func _ready() -> void:
	state_machine.init(self)

func take_damage(damage):
	if !invinsible:
		state_machine.change_state(hurt_state)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func _on_invinsibility_timeout() -> void:
	invinsible = false
	print("no invinsibility")
