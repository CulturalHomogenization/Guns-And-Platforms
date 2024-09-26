extends State

#states assigned in editor
@export var jump_state: State
@export var idle_state: State
@export var move_state: State

func enter() -> void:
	super()

func process_physics(delta: float) -> State:
	owner.velocity.y += gravity * delta #falling obviously, because its a fall state

	var movement = Input.get_axis('move_left', 'move_right') * move_speed #direction based on input
	
	if movement != 0:
		if movement != 0:
			owner.animations.flip_h = movement < 0
		if movement < 0:
			owner.animations.flip_h = true# once again the animation flipping
		else:
			owner.animations.flip_h = false
	owner.velocity.x = movement#as you can see, this is considering the x and y velocities seperately
	owner.move_and_slide()
	
	if owner.is_on_floor():
		if movement != 0:
			return move_state #if you are on the floor youre no longer falling, therefore a state needs to be returned.
		return idle_state# if you are on the floor and not moving then youre lazy, oh wait, youre idle
	return null
