extends Boss_State
@export var walk_state: Boss_State

func enter() -> void:
	owner.animations.play(animation_name)
	owner.shield_timer.wait_time = 1
	owner.shield_timer.start()
	for spawn_point in owner.camera.enemy_spawner.get_children():
		var enemy = owner.enemy_drone.instantiate()
		enemy.global_position = spawn_point.global_position
		add_child(enemy)

func exit() -> void:
	owner.shield_timer.wait_time = 3
	owner.shield_timer.start()

func process_frame(delta: float) -> Boss_State:
	if owner.shield:
		return null
	else:
		return walk_state

func _on_shield_timer_timeout() -> void:
	if owner.shield_timer.wait_time == 1:
		owner.shield = false
