extends State

@export var fall_state: State
@export var idle_state: State
@export var move_state: State

@export var jump_force: float = 300.0

func enter() -> void:
	super()
	owner.velocity.y = -jump_force

func process_physics(delta: float) -> State:
	owner.velocity.y += gravity * delta
	
	if owner.velocity.y > 0:
		return fall_state
	
	var movement = Input.get_axis('move_left', 'move_right') * move_speed
	
	if movement != 0:
		owner.animations.flip_h = movement < 0
		if movement < 0:
			owner.animations.flip_h = true
			owner.animations.offset.x = -10
		else:
			owner.animations.flip_h = false
			owner.animations.offset.x = 10
			
	owner.velocity.x = movement
	owner.move_and_slide()
	
	if owner.is_on_floor():
		if movement != 0:
			return move_state
		return idle_state
	return null
