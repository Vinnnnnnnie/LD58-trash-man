extends Control
var tween_speed = 0.75

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cool_rotation() # Replace with function body.

func cool_rotation():
	var tween = get_tree().create_tween()
	tween.tween_property($Label, 'rotation', PI/24, tween_speed)
	tween.tween_callback(cool_rotation_back)

func cool_rotation_back():
	var tween = get_tree().create_tween()
	tween.tween_property($Label, 'rotation', -PI/24, tween_speed)
	tween.tween_callback(cool_rotation)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func new_area(message):
	self.show()
	$Label.text = message
	$Timer.start($Timer.wait_time)

func _on_timer_timeout() -> void:
	self.hide()
