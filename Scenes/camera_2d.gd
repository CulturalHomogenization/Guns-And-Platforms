extends Camera2D

@onready var enemy_spawner: Node2D = $EnemySpawner/SpawnPoints
# this is just so taht the boss can have a reference to the spawn points.
# im sure there are better ways to do this, but i do have trouble referencing objects.
