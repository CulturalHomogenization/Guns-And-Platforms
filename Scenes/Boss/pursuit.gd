extends Boss_State

@export var smash_state : Boss_State
var movement = null

func enter() -> void:
	super()

func exit() -> void:
	owner.caught = false

func process_physics(delta: float) -> Boss_State:
	if !owner.caught: #if the player isnt caught, then dont smash if yk yk
		owner.velocity.y += gravity * delta
		if owner.player.global_position.x >= owner.global_position.x:
			movement = move_speed
		else:
			movement = -move_speed

		if movement < 0:
			owner.animations.flip_h = true #flipping the sprite based on direction, just another day in Godot
		else:
			owner.animations.flip_h = false
		owner.velocity.x = movement
		owner.move_and_slide() #the lines above detects where the player is relative to the boss so that it can move accordingly
		return null
	else:
		return smash_state #when player is caught, transistions into smash state

func _on_projectile_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		owner.caught = true #when player enters a certain area2d, then it is defined as "caught"
