extends Boss_State
@export var walk_state: Boss_State
@export var damage : int = 5

func enter() -> void:
	super()
	owner.caught = true

func process_frame(delta: float) -> Boss_State:
	if owner.caught:
		if owner.animations.frame == 2 or 3:
			owner.player.take_damage(damage)
		return null
	else:
		return walk_state

func _on_projectile_detection_body_exited(body: Node2D) -> void:
	owner.caught = false
