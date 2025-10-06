extends Control
signal game_over
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cool_rotation()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$TimerLabel.text = str(floor($Timer.time_left))
	pass

func cool_rotation():
	var label_font_size = $TimerLabel.get('label_settings').font_size
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	tween.tween_property(self, 'rotation', PI/28, 1)
	tween2.tween_property($TimerLabel.get('label_settings'), 'font_size', 74, 1)

	tween.tween_callback(cool_rotation_back)
	
func cool_rotation_back():
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()

	tween.tween_property(self, 'rotation', -PI/24, 1)
	tween2.tween_property($TimerLabel.get('label_settings'), 'font_size', 64, 1)
	
	tween.tween_callback(cool_rotation)

func gain_time(time_gained):
	$GainAmount.text = "+ " + str(time_gained)
	$AnimationPlayer.play("gain_time")
	$Timer.start($Timer.time_left + time_gained)
	print('Waittime:'+str($Timer.time_left))

func _on_timer_timeout() -> void:
	emit_signal('game_over')
