class_name Boss
extends CharacterBody2D


#many many variables that will be used.
@onready var health_bar: ProgressBar = $CanvasLayer/HealthBar
@onready var animations = $animations
@onready var state_machine = $state_machine
@onready var hitbox: Area2D = $Hitbox
@onready var projectile_detection: Area2D = $ProjectileDetection
@onready var player = get_tree().get_first_node_in_group("Player")
var health = 1000
@onready var player_detection: Area2D = $PlayerDetection
@export var shield_state : Boss_State
@onready var shield_timer: Timer = $ProjectileDetection/ShieldTimer
var caught = false
var shield : bool = true
@onready var hurtbox: CollisionShape2D = $Hurtbox/CollisionShape2D
@onready var enemy_drone = preload("res://Scenes/AttackDrone/attack_drone.tscn")
@onready var camera = get_tree().get_first_node_in_group("Spawner")


#initializes state machine as well as health bar, ran once at the start of the program
func _ready() -> void:
	state_machine.init(self)
	health_bar.init_health(health)

#handles taking damage, but only if shield state is not possible.
func take_damage(damage):
	if state_machine.current_state != shield_state:
		if health >= damage:
			health -= damage
			health_bar.health = health
		else:
			state_machine.current_state = shield_state
			queue_free()

#declares 3 new functions which allows you to have full control over what each of them do.
func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
func _process(delta: float) -> void:
	state_machine.process_frame(delta)
