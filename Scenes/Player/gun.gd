extends AnimatedSprite2D

var can_fire : bool = true
var bullet = preload("res://Scenes/Player/Bullet.tscn")
@onready var timer: Timer = $Timer

func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	
	if Input.is_action_pressed("shoot") and can_fire:
		var bullet_instance = bullet.instantiate()
		bullet_instance.rotation = rotation + randf_range(-0.2, 0.2)
		bullet_instance.global_position = $Marker2D.global_position
		get_parent().add_child(bullet_instance)
		can_fire = false
		timer.start()


func _on_timer_timeout() -> void:
	can_fire = true
