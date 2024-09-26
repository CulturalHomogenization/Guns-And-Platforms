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
	#you cannot shoot if youre not shooting, you cannot shoot if you have no ammo, you cannot shoot if youre dead, and you cannot shoot if youre being hurt
	if Input.is_action_pressed("shoot") and can_fire and ammo > 0 and !owner.dead and !owner.state_machine.current_state == hurt_state:
		var bullet_instance = bullet.instantiate()#instantiates a bullet
		bullet_instance.rotation = rotation + randf_range(-0.1, 0.1)#adds a little bit of inaccuracy
		bullet_instance.global_position = $Marker2D.global_position#marker2D is the muzzle of the gun, so that the bullet always shoots from the muzzle
		get_parent().add_child(bullet_instance)#finally, adds the bullet to the scene tree
		ammo -= 1 #removes 1 ammo
		can_fire = false #need to wait till shoot cooldown is over again
		timer.start() # cooldown timer started
	elif Input.is_action_pressed("shoot") and ammo <=0 and reload_timer.is_stopped():
		reload_timer.start()
		#this makes sure that you have to press to reload.


func _on_timer_timeout() -> void:
	can_fire = true
#after your fire cooldown is over, you can fire again

func _on_reload_timer_timeout() -> void:
	ammo = 10
#after reloading, your ammo is full again
