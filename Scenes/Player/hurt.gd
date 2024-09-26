extends State

@export var move_state: State
@onready var timer: Timer = $Timer
var invinsible : bool = true

func enter() -> void:
	super()#plays hurt animation
	owner.invinsible = true
	invinsible = true
	timer.start()

func exit() -> void:
	owner.invinsibility.start() #this is the start of the invinsibility frame after the hurt state is exited

func process_frame(delta: float) -> State:
	if invinsible:
		if !owner.is_on_floor():
			owner.velocity.y += gravity * delta #during hurt state you cannot move, you can only fall if youre not on the ground
			owner.move_and_slide()
		return null
	else:
		return move_state

func _on_timer_timeout() -> void:
	invinsible = false #once the timer runs out, hurt state is exited
