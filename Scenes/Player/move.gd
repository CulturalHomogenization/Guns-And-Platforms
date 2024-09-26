extends State

@export var fall_state: State
@export var idle_state: State
@export var jump_state: State
@export var dash_state: State
var movement = null

func enter() -> void:
	super()
	movement = Input.get_axis('move_left', 'move_right') * move_speed #you are moving
	owner.move_and_slide()

func process_input(event: InputEvent) -> State:
	if Input.is_action_pressed('jump') and owner.is_on_floor(): #if you jump, then youre jumping, therefore jump state
		return jump_state
	elif Input.is_action_pressed('dash') and owner.dash:
		return dash_state #if you dash, then youre dashing, therefore dash state
	return null

func process_physics(delta: float) -> State:
	owner.velocity.y += gravity * delta
	
	var movement = Input.get_axis('move_left', 'move_right') * move_speed #this is important because its determining the direction
	
	if movement == 0:
		return idle_state #if your velocity = 0, you are not moving there fore you are idle
	
	if movement < 0:
		owner.animations.flip_h = true
	else:
		owner.animations.flip_h = false #more flipping the animated sprite
	owner.velocity.x = movement
	owner.move_and_slide()
	
	if !owner.is_on_floor():
		return fall_state #if youre not on the floor youre falling
	return null
