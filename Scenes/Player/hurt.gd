extends State

@export var move_state: State
@onready var timer: Timer = $Timer
var invinsible : bool = true

func enter() -> void:
	super()
	owner.invinsible = true
	invinsible = true
	timer.start()

func exit() -> void:
	owner.invinsibility.start()

func process_frame(delta: float) -> State:
	if invinsible:
		if !owner.is_on_floor():
			owner.velocity.y += gravity * delta
			owner.move_and_slide()
		return null
	else:
		return move_state

func _on_timer_timeout() -> void:
	invinsible = false
