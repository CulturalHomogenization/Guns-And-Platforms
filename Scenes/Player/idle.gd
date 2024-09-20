extends State

@export var fall_state: State
@export var jump_state: State
@export var move_state: State

func enter() -> void:
	super()
	owner.velocity.x = 0
	if owner.animations.flip_h == true:
		owner.animations.offset.x = -5
	else:
		owner.animations.offset.x = 16



func process_input(event: InputEvent) -> State:
	if Input.is_action_pressed('jump') and owner.is_on_floor():
		return jump_state
	if Input.is_action_pressed('move_left') or Input.is_action_pressed('move_right'):
		return move_state
	return null

func process_physics(delta: float) -> State:
	owner.velocity.y += gravity * delta
	owner.move_and_slide()
	
	if !owner.is_on_floor():
		return fall_state
	return null
