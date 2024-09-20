extends State

@export var jump_state: State
@export var idle_state: State
@export var move_state: State

func enter() -> void:
	super()

func process_physics(delta: float) -> State:
	owner.velocity.y += gravity * delta

	var movement = Input.get_axis('move_left', 'move_right') * move_speed
	
	if movement != 0:
		if movement != 0:
			owner.animations.flip_h = movement < 0
		if movement < 0:
			owner.animations.flip_h = true
		else:
			owner.animations.flip_h = false
	owner.velocity.x = movement
	owner.move_and_slide()
	
	if owner.is_on_floor():
		if movement != 0:
			return move_state
		return idle_state
	return null
