extends State

@export var move_state: State
var dash = false

@onready var timer: Timer = $Timer

func enter() -> void:
	dash = true
	timer.start()
	super()
	owner.gun.visible = false
	owner.dash = false
	owner.dash_timer.start()
	owner.collision.disabled = true #these lines hide the gun and disables the collisionshape so you can just phase through the boss

func exit() -> void:
	owner.gun.visible = true
	owner.collision.disabled = false
	#shows gun again obviously and reenables collisionshape

func process_physics(delta: float) -> State:
	if dash:
		if owner.animations.flip_h:
			owner.velocity.x = -move_speed # ahh yes the animation flipping, just doesnt get old
		else:
			owner.velocity.x = move_speed
		owner.move_and_slide()
		return null
	else:
		return move_state


func _on_timer_timeout() -> void:
	dash = false
#this is just to control how long you dash for
