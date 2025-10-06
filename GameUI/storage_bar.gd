extends Control
var tween_speed
var rotation_disabled = false

func _ready() -> void:
	tween_speed = 0.75
	$ProgressBar.value = 100
	cool_rotation()

func cool_rotation():
	var label_font_size = $StorageLabel.get('label_settings').font_size
	var tween = get_tree().create_tween()
	tween.tween_property($StorageLabel, 'rotation', PI/24, tween_speed)

	tween.tween_callback(cool_rotation_back)
	
func cool_rotation_back():
	var tween = get_tree().create_tween()

	tween.tween_property($StorageLabel, 'rotation', -PI/24, tween_speed)
	
	tween.tween_callback(cool_rotation)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func storage_full():
	$StorageLabel.text = 'FULL'
	tween_speed = 0.25
	rotation_disabled = false
	cool_rotation2()
	
	

func storage_empty():
	
	tween_speed = 0.25
	rotation_disabled = true
	var tween3 = get_tree().create_tween()
	tween3.tween_property($ProgressBar, 'rotation', 0, tween_speed)
	
	
func cool_rotation2():
	if rotation_disabled == false:
		var label_font_size = $ProgressBar
		var tween = get_tree().create_tween()
		var tween2 = get_tree().create_tween()
		tween.tween_property($ProgressBar, 'rotation', PI/24, tween_speed)
		tween2.tween_property($ProgressBar, 'scale', 1.5, tween_speed)
		tween.tween_callback(cool_rotation_back2)
	
func cool_rotation_back2():
	if rotation_disabled == false:
		var tween = get_tree().create_tween()
		var tween2 = get_tree().create_tween()

		tween.tween_property($ProgressBar, 'rotation', -PI/24, tween_speed)
		tween2.tween_property($ProgressBar, 'scale', 1, tween_speed)
		
		tween.tween_callback(cool_rotation2)
