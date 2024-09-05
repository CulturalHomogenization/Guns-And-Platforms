extends State

var movement = null

func enter() -> void:
	super()
	movement = Input.get_axis('move_left', 'move_right') * move_speed
	owner.move_and_slide()


func process_physics(delta: float) -> State:
	owner.velocity.y += gravity * delta
	
	var movement = Input.get_axis('move_left', 'move_right') * move_speed
	
	if movement == 0:
		return null
	
	if movement < 0:
		owner.animations.flip_h = true
		owner.animations.offset.x = -10
	else:
		owner.animations.flip_h = false
		owner.animations.offset.x = 10
	owner.velocity.x = movement
	owner.move_and_slide()
	
	if !owner.is_on_floor():
		return null
	return null
