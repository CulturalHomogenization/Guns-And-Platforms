extends State

@onready var timer: Timer = $Timer

func enter() -> void:
	owner.animations.animation = "death"
	owner.dead = true
	owner.gun.visible = false
	await get_tree().create_timer(1.0).timeout
	if get_tree():
		get_tree().reload_current_scene()
