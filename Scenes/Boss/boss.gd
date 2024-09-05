class_name Boss
extends CharacterBody2D

@onready var animations = $animations
@onready var state_machine = $state_machine
@onready var hitbox: Area2D = $Hitbox
@onready var projectile_detection: Area2D = $ProjectileDetection
@onready var player: Player = owner.get_parent().find_child("Player")

func _ready() -> void:
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
func _process(delta: float) -> void:
	state_machine.process_frame(delta)
