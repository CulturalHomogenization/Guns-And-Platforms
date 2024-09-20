extends State

@export var move_state: State
@onready var timer: Timer = $Timer
var invinsible : bool = true
var offset = null

func enter() -> void:
	super()
	offset = owner.animations.offset
	owner.animations.offset.x = 0
	owner.invinsible = true
	invinsible = true
	timer.start()

func exit() -> void:
	owner.invinsibility.start()

func process_frame(delta: float) -> State:
	if invinsible:
		return null
	else:
		return move_state

func _on_timer_timeout() -> void:
	invinsible = false
