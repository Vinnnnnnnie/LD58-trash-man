extends Control


# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	pass
	
func _ready() -> void:
	$ProgressBar.value = 100
	cool_rotation()

func cool_rotation():
	var label_font_size = $BoostBarLabel.get('label_settings').font_size
	var tween = get_tree().create_tween()
	tween.tween_property($BoostBarLabel, 'rotation', PI/24, 0.75)

	tween.tween_callback(cool_rotation_back)
	
func cool_rotation_back():
	var tween = get_tree().create_tween()

	tween.tween_property($BoostBarLabel, 'rotation', -PI/24, 0.75)
	
	tween.tween_callback(cool_rotation)
