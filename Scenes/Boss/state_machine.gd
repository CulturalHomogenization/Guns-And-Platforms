extends Node

#the brains behind it all...
# this is the script that controls the changing of states
# whenever a state is returned, it is up to this script to decide what to do with it
# this changing of states is handled by the change_state()function

@export var shield_state : Boss_State
@export var starting_state: Boss_State 
@export var current_state: Boss_State

func init(parent: Boss) -> void:
	for child in get_children():
		child.reparent(parent)
	change_state(starting_state)
#This reparenting is very important because it means that each of the states will no longer be children of the state machine
# but a child of the boss. This means that it can directly reference the boss and therefore its variables and attributes
# by using owner.(something something brackets no brackets you get what i mean)

func change_state(new_state: Boss_State) -> void:
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter() #change state function, each state gets to use its exit function to clean up before switching to a new state

func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state) #if a state is retuned change state function is called.

func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)#if a state is retuned change state function is called.

func process_frame(delta: float) -> void:
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)#if a state is retuned change state function is called.

func _on_timer_timeout() -> void:
	if owner.shield_timer.wait_time == 3:
		owner.shield = true
#if its equal to the shield down time which is 3, then therefore the shield down time ran out, and therefore the shield can be put up again if needed.

func _on_projectile_detection_area_entered(area: Area2D) -> void:
	if owner.shield and current_state != shield_state:
		if area.is_in_group("Bullet"):
			change_state(shield_state)
#the if statements are nested because i was debugging but now i cant be bothered changing them back, since they do the same thing either way
