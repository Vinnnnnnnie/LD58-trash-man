extends AudioStreamPlayer2D
var screech = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_car_drift() -> void:
	screech_tyre()
	screech = false
	pass # Replace with function body.

func screech_tyre():
	if screech == true:
		pitch_scale = randf_range(1, 1.2)
		play(0)
		
		

func _on_car_not_drift() -> void:
	stop()
	screech = true
