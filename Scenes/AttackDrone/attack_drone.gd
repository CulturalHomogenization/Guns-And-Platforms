extends CharacterBody2D

#declares variables which will be used.
@onready var animations: AnimatedSprite2D = $animations
@export var speed = 150
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var navigation_agent := $NavigationAgent2D as NavigationAgent2D
var player_caught = false
var damage = 1
@onready var health_bar: ProgressBar = $HealthBar
var health = 15

#This sets the healthbar up so that the health bar is actually configured to the drone health
func _ready() -> void:
	health_bar.init_health(health)

#function which handles taking damage, should be pretty straight forward to understand
func take_damage(damage):
	animations.play("hurt")
	health -= damage
	health_bar.health = health
	if health <= 0:
		queue_free()

# processed every frame, the navigation agent allows the drone to path find towards a point ontop of the player, marked by a marker2d node
func _physics_process(delta: float) -> void:
	if !player_caught:
		animations.play("pursuit")
		var direction = (navigation_agent.get_next_path_position() - global_position).normalized()
		translate(direction * speed * delta)
		move_and_slide()

#processed every frame, handles player taking damage here as it does not belong in physics process
func _process(delta: float) -> void:
	if player_caught:
		animations.play("attack")
		if animations.frame == 2:
			player.take_damage(damage)
	if player.dead:
		queue_free() #this was added for a bug fix, not sure why but it fixes the bug so I ain't complaining

func makepath() -> void:
	navigation_agent.target_position = player.marker.global_position #just setting up the path to go towards the player

func _on_timer_timeout() -> void:
	makepath() # everytime the timer run out, a new path is calculated, this means that a new path is calculated once every 5 seconds

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_caught = true #differienciates whether or not the drone still needs to move towards the player or can just attack

func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_caught = false #same as above
