extends Boss_State
@export var walk_state: Boss_State
@export var damage : int = 5

func enter() -> void:
	super()
	owner.caught = true

func process_frame(delta: float) -> Boss_State:
	if owner.caught:
		if owner.animations.frame == 2 or owner.animations.frame == 3 or owner.animations.frame == 4:
			owner.player.take_damage(damage)
		return null
	else:
		return walk_state

func _on_projectile_detection_body_exited(body: Node2D):
	if body.is_in_group("Player"):
		owner.caught = false
