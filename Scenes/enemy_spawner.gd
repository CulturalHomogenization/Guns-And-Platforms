extends Node

@onready var spawn_timer: Timer = $SpawnTimer
@onready var spawn_points = $SpawnPoints.get_children()
@onready var world = get_node("/root/World")
@onready var camera = $".."
const drone = preload("res://Scenes/AttackDrone/attack_drone.tscn")

func spawn_enemy():
	var enemy = drone.instantiate()
	var spawn_point = spawn_points.pick_random()
	enemy.global_position = spawn_point.global_position
	world.add_child(enemy)

func _on_spawn_timer_timeout() -> void:
	#spawn_enemy()
	#print("spawned")
	#spawn_timer.start()
	pass
