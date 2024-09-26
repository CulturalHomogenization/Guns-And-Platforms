extends State

@export var fall_state: State
@export var idle_state: State
@export var move_state: State

@export var jump_force: float = 300.0

func enter() -> void:
	super()
	owner.velocity.y = -jump_force #because you jump up immediately and then slow down and then stop and then fall down again.

func process_physics(delta: float) -> State:
	owner.velocity.y += gravity * delta
	
	if owner.velocity.y > 0:
		return fall_state
	
	var movement = Input.get_axis('move_left', 'move_right') * move_speed #so that you can move while in the air
	
	if movement != 0:
		owner.animations.flip_h = movement < 0
		if movement < 0:
			owner.animations.flip_h = true # another round of flipping the animated sprite
		else:
			owner.animations.flip_h = false
			
	owner.velocity.x = movement
	owner.move_and_slide()
	
	if owner.is_on_floor():
		if movement != 0:
			return move_state #if youre on the floor, the you are no longer jumping, therefore if youre moving also, youre in move state
		return idle_state #if youre not? then youre idle
	return null
