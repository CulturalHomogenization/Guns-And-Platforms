extends Timer


@onready var dash: ProgressBar = $"../CanvasLayer/Dash"

func _ready() -> void:
	dash.max_value = wait_time

func _process(delta: float) -> void:
	dash.value = time_left
