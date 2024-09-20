extends Boss_State
@export var walk_state: Boss_State

func enter() -> void:
	owner.animations.play(animation_name)
	owner.shield_timer.wait_time = 5
	owner.shield_timer.start()

func exit() -> void:
	owner.shield_timer.wait_time = 10
	owner.shield_timer.start()

func process_frame(delta: float) -> Boss_State:
	if owner.shield:
		return null
	else:
		return walk_state

func _on_shield_timer_timeout() -> void:
	if owner.shield_timer.wait_time == 5:
		owner.shield = false
