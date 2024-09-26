extends State

@export var fall_state: State
@export var jump_state: State
@export var move_state: State
@export var dash_state: State

func enter() -> void:
	super()
	owner.velocity.x = 0 #not sure why this is important because idle state should already mean that velocity.x=0


func process_input(event: InputEvent) -> State:
	if Input.is_action_pressed('jump') and owner.is_on_floor(): 
		return jump_state # well this is straight forward, if you jump, youre jumping
	if Input.is_action_pressed('move_left') or Input.is_action_pressed('move_right'):
		return move_state # if you move, youre moving
	elif Input.is_action_pressed('dash') and owner.dash:
		return dash_state # and lucky last if you dash, youre dashing
	return null

func process_physics(delta: float) -> State:
	owner.velocity.y += gravity * delta
	owner.move_and_slide()
	
	if !owner.is_on_floor():
		return fall_state #well if youre not on the floor, then youre falling? no way!
	return null
