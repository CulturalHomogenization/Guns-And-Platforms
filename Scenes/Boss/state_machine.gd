extends Node

@export var shield_state : Boss_State
@export var starting_state: Boss_State
var current_state: Boss_State

func init(parent: Boss) -> void:
	for child in get_children():
		child.reparent(parent)
	change_state(starting_state)

func change_state(new_state: Boss_State) -> void:
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()

func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)

func _on_timer_timeout() -> void:
	if owner.shield_timer.wait_time == 10:
		owner.shield = true

func _on_projectile_detection_area_entered(area: Area2D) -> void:
	print("something")
	if owner.shield and current_state != shield_state:
		print("bullet???")
		if area.is_in_group("Bullet"):
			print("bullet")
			change_state(shield_state)
