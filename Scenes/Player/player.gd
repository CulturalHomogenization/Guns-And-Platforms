class_name Player
extends CharacterBody2D

#these are all referenced by the states using owner.... thats why you do not see these being used here.
@onready var animations = $animations
@onready var state_machine = $state_machine
@export var hurt_state : State
@export var death_state : State
var dead = false
var invinsible : bool = false
var dash : bool = false
@onready var invinsibility : Timer = $Invinsibility
@onready var dash_timer : Timer = $Dash
@onready var gun: AnimatedSprite2D = $gun
@onready var collision: CollisionShape2D = $collision
@onready var marker: Marker2D = $Marker2D
var health = 10
@onready var health_bar: ProgressBar = $CanvasLayer/HealthBar
@onready var boss = get_tree().get_first_node_in_group("Enemies")
@onready var label: Label = $CanvasLayer/Label


func _ready() -> void:
	animations.offset.x = 0 #just for consistency sake
	state_machine.init(self) #initilises state machine, which then reparents all the states to the player
	health_bar.init_health(health) #init the health bar, so that the health bar now has a max value of 10

func take_damage(damage):
	if !invinsible:
		health -= damage
		if health > 0:
			health_bar.health = health
			state_machine.change_state(hurt_state)
			#what doesnt kill me makes me stronger, but not really, in this case youre just 1 or 5 health closer to death_state
			#but for now you can just go to hurt state
		else:
			state_machine.change_state(death_state)
			#if youre out of health, then you go to a state of death, or rather, death_state

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
func _process(delta: float) -> void:
	if boss.health == 0:
		label.visible = true
		get_tree().paused = true
	state_machine.process_frame(delta)
#if the boss is killed, the you win label appears and the game is paused

func _on_invinsibility_timeout() -> void:
	invinsible = false
#if your invinsibility timer times out, then you are no long invinsible

func _on_dash_timeout() -> void:
	dash = true
	dash_timer.autostart = false
#when the dash timer runs out, you are ready to dash again
