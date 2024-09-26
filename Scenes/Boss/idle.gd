extends Boss_State
@export var walk_state: Boss_State
var player_entered: bool = false

#this is the code for the idle state of the boss, very very basic
#it first of all plays the idle animation, with the line super() and then
#just waits till a player is detected, at which point it transitions into walk state
# to start pursuit. thats all it does.

func enter() -> void:
	super()

func process_frame(delta: float) -> Boss_State:
	if player_entered == true:
		return walk_state
	else:
		return null

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_entered = true
