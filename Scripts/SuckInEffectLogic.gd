extends PathFollow2D

const start_point = 0.8405
const end_point = 0.1

@export var animation_speed = 2
var enable_effect = false

func _ready() -> void:
	progress_ratio = start_point

func start_effect() -> void:
	enable_effect = true

func _physics_process(delta: float) -> void:
	if enable_effect:
		progress_ratio = lerpf(progress_ratio, 0, get_physics_process_delta_time() * animation_speed)
	
		if progress_ratio <= end_point:
			queue_free()
