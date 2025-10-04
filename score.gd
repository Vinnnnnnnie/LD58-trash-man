extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cool_rotation()


func _process(delta: float) -> void:
	pass

func cool_rotation():
	var label_font_size = $ScoreNumber.get('label_settings').font_size
	print('FONT SIZER',label_font_size)
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	tween.tween_property(self, 'rotation', -PI/28, 1)
	tween2.tween_property($ScoreNumber.get('label_settings'), 'font_size', 74, 1)

	tween.tween_callback(cool_rotation_back)
	
func cool_rotation_back():
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()

	tween.tween_property(self, 'rotation', PI/28, 1)
	tween2.tween_property($ScoreNumber.get('label_settings'), 'font_size', 64, 1)
	
	tween.tween_callback(cool_rotation)
