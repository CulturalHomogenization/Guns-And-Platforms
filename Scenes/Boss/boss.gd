class_name Boss
extends CharacterBody2D

@onready var animations = $animations
@onready var state_machine = $state_machine
@onready var hitbox: Area2D = $Hitbox
@onready var projectile_detection: Area2D = $ProjectileDetection
@onready var player = get_tree().get_first_node_in_group("Player")
@export var health : int = 1000
@onready var player_detection: Area2D = $PlayerDetection
@export var shield_state : Boss_State
@onready var shield_timer: Timer = $ProjectileDetection/ShieldTimer
var caught = false
var shield : bool = true


func _ready() -> void:
	state_machine.init(self)

func take_damage(damage):
	if state_machine.current_state != shield_state:
		health -= damage
		print(health)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
func _process(delta: float) -> void:
	state_machine.process_frame(delta)
