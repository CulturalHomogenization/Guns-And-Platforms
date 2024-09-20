extends Area2D

@export var speed : int = 1000
@export var damage : int = 5

func _ready() -> void:
	set_as_top_level(true)

func _physics_process(delta: float) -> void:
	await(get_tree().create_timer(0.01))
	set_physics_process(false)

func _process(delta: float) -> void:
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		pass
	elif body.is_in_group("Enemies") and body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()
	else:
		queue_free()
