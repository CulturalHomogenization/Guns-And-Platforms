extends Boss_State
@export var walk_state: Boss_State
@export var damage : int = 5

func enter() -> void:
	super()
	owner.caught = true #not sure if this line actually does anything but added it just to be safe will debugging.

func process_frame(delta: float) -> Boss_State:
	if owner.caught:
		if owner.animations.frame == 2 or owner.animations.frame == 3 or owner.animations.frame == 4: #this is very important because it means that the player will only be damaged on the attacking frames of the attack animation, as you dont get killed because someone lifted their arms to punch you
			owner.player.take_damage(damage)
		return null
	else:
		return walk_state #once again, once the condition is no longer true, go back to chasing the player

func _on_projectile_detection_body_exited(body: Node2D):
	if body.is_in_group("Player"):
		owner.caught = false #player is no longer in range if it leaves the area2d
