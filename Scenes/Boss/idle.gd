extends Boss_State
@export var walk_state: Boss_State
var player_entered: bool = false

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
