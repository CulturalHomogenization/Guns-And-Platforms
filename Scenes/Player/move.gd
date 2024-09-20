extends State

@export var fall_state: State
@export var idle_state: State
@export var jump_state: State
var movement = null

func enter() -> void:
	super()
	movement = Input.get_axis('move_left', 'move_right') * move_speed
	owner.move_and_slide()

func process_input(event: InputEvent) -> State:
	if Input.is_action_pressed('jump') and owner.is_on_floor():
		return jump_state
	return null

func process_physics(delta: float) -> State:
	owner.velocity.y += gravity * delta
	
	var movement = Input.get_axis('move_left', 'move_right') * move_speed
	
	if movement == 0:
		return idle_state
	
	if movement < 0:
		owner.animations.flip_h = true
		owner.animations.offset.x = 0
	else:
		owner.animations.flip_h = false
		owner.animations.offset.x = 10
	owner.velocity.x = movement
	owner.move_and_slide()
	
	if !owner.is_on_floor():
		return fall_state
	return null
