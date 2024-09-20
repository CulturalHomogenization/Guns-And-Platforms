extends State

@export var move_state: State
@onready var timer: Timer = $Timer
var invinsible : bool = true

func enter() -> void:
	super()
	invinsible = true
	timer.start()

func process_frame(delta: float) -> State:
	if invinsible:
		return null
	else:
		return move_state

func _on_timer_timeout() -> void:
	invinsible = false
