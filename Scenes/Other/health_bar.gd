extends ProgressBar

@onready var damage_bar: ProgressBar = $DamageBar
@onready var timer: Timer = $Timer

var health = 0 : set = _set_health

#I am not fully sure how this works but I'll give it my best shot.

func _set_health(new_health): #this function is called every time the health is changed
	var prev_health = health
	health = min(max_value, new_health)
	value = health
	
	if health <= 0: # well if health less than or equal to zero, then the thing is dead, then there needs to be no healthbar
		queue_free()
	if health < prev_health: # if its taking damage but still alive, then we can make it take damage, the timer is for the delayed effect that you can see when you play
		timer.start()
	else:
		damage_bar.value = health # well if its not taking damage then its healing, then there needs to be no delay and we will just set it straight to the health

func init_health(_health): #initializes the healthbar so that it can work for anything will a health, this is because the max values and values at the start are all changed by this function, very useful
	health = _health
	self.max_value = health
	value = health
	damage_bar.max_value = health
	damage_bar.value = health

func _on_timer_timeout() -> void:
	damage_bar.value = health #once delay is done, set the damage bar which is the white one undersneath to the actual health
