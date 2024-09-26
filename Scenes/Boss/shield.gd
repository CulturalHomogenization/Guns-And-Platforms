extends Boss_State
@export var walk_state: Boss_State

#shield is an interesting one, this is because you have to consider both shield uptime as well as down time
#and because I like to over complicated things, I used a single timer for managing these 2
func enter() -> void:
	owner.animations.play(animation_name)
	owner.shield_timer.wait_time = 1 #starts a timer for 1 second of shield up time
	owner.shield_timer.start()
	for spawn_point in owner.camera.enemy_spawner.get_children(): #very important, these lines spawns the drone enemies
		var enemy = owner.enemy_drone.instantiate() #fun fact, they were added because I found that just standing there wait for the boss to finish shielding itself is very very dry gameplay.
		enemy.global_position = spawn_point.global_position
		add_child(enemy) #very standard code here, gets a list of marker positions and spawns an enemy at each one.

func exit() -> void:
	owner.shield_timer.wait_time = 3
	owner.shield_timer.start() #starts a timer for shield downtime before exiting shield state

func process_frame(delta: float) -> Boss_State:
	if owner.shield:
		return null
	else:
		return walk_state #once shield up time is finished, return to walk state.

func _on_shield_timer_timeout() -> void:
	if owner.shield_timer.wait_time == 1:
		owner.shield = false
#owner.shield = false means that shielding is not possible and the boss will have to wait till its true again to use the shield
