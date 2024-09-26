extends AnimatedSprite2D

var can_fire : bool = true
var bullet = preload("res://Scenes/Player/Bullet.tscn")
@onready var timer: Timer = $Timer
var ammo = 10
@onready var reload_timer: Timer = $ReloadTimer
@export var hurt_state : State

func _physics_process(delta: float) -> void:
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	
	if Input.is_action_pressed("shoot") and can_fire and ammo > 0 and !owner.dead and !owner.state_machine.current_state == hurt_state:
		var bullet_instance = bullet.instantiate()
		bullet_instance.rotation = rotation + randf_range(-0.1, 0.1)
		bullet_instance.global_position = $Marker2D.global_position
		get_parent().add_child(bullet_instance)
		ammo -= 1
		can_fire = false
		timer.start()
	elif Input.is_action_pressed("shoot") and ammo <=0 and reload_timer.is_stopped():
		reload_timer.start()


func _on_timer_timeout() -> void:
	can_fire = true


func _on_reload_timer_timeout() -> void:
	ammo = 10
