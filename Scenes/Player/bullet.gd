extends Area2D

@export var speed : int = 1200
@export var damage : int = 5
@onready var timer: Timer = $Timer

func _ready() -> void:
	set_as_top_level(true)

func _physics_process(delta: float) -> void:
	await(get_tree().create_timer(0.01))
	set_physics_process(false)

func _process(delta: float) -> void:
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta
	#moves the bullet

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free() # if its not on screen, just delete it

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		pass #dont damage the player by shooting lol
	elif body.is_in_group("Enemies") and body.has_method("take_damage"):
		body.take_damage(damage)
		timer.start() #but if its an enemy, then i have made sure that they have a take_damage function and they will take damage upon being hit by a bullet
	else:
		queue_free()

func _on_timer_timeout() -> void:
	queue_free()
#not going to lie, this timer was added for a bugfix, where if you stand close enough to the boss you can shoot straight through him
