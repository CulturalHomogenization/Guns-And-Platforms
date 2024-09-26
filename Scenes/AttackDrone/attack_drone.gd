extends CharacterBody2D

@onready var animations: AnimatedSprite2D = $animations
@export var speed = 150
@onready var player = get_tree().get_first_node_in_group("Player")
@onready var navigation_agent := $NavigationAgent2D as NavigationAgent2D
var player_caught = false
var damage = 1
@onready var health_bar: ProgressBar = $HealthBar
var health = 15

func _ready() -> void:
	health_bar.init_health(health)

func take_damage(damage):
	animations.play("hurt")
	health -= damage
	health_bar.health = health
	if health <= 0:
		queue_free()


func _physics_process(delta: float) -> void:
	if !player_caught:
		animations.play("pursuit")
		var direction = (navigation_agent.get_next_path_position() - global_position).normalized()
		translate(direction * speed * delta)
		move_and_slide()

func _process(delta: float) -> void:
	if player_caught:
		animations.play("attack")
		if animations.frame == 2:
			player.take_damage(damage)
	if player.dead:
		queue_free()

func makepath() -> void:
	navigation_agent.target_position = player.marker.global_position

func _on_timer_timeout() -> void:
	makepath()

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_caught = true

func _on_player_detection_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_caught = false
