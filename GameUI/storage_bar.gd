extends Control


func _ready() -> void:
	$ProgressBar.value = 100
	cool_rotation()

func cool_rotation():
	var label_font_size = $StorageLabel.get('label_settings').font_size
	var tween = get_tree().create_tween()
	tween.tween_property($StorageLabel, 'rotation', PI/24, 0.75)

	tween.tween_callback(cool_rotation_back)
	
func cool_rotation_back():
	var tween = get_tree().create_tween()

	tween.tween_property($StorageLabel, 'rotation', -PI/24, 0.75)
	
	tween.tween_callback(cool_rotation)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
