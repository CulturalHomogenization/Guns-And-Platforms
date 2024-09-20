extends Boss_State

@export var smash_state : Boss_State
var movement = null

func enter() -> void:
	super()

func exit() -> void:
	owner.caught = false

func process_physics(delta: float) -> Boss_State:
	if !owner.caught:
		owner.velocity.y += gravity * delta
		if owner.player.global_position.x >= owner.global_position.x:
			movement = move_speed
		else:
			movement = -move_speed

		if movement < 0:
			owner.animations.flip_h = true
		else:
			owner.animations.flip_h = false
		owner.velocity.x = movement
		owner.move_and_slide()
		return null
	else:
		return smash_state

func _on_projectile_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		owner.caught = true
