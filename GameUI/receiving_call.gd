extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cool_rotation()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func cool_rotation():
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	#tween.tween_property(self, 'rotation', -PI/28, 0.5)
	#tween.tween_property(self, 'rotation', PI/28, 0.5)
	#tween.tween_property(self, 'rotation', -PI/28, 0.5)
	#tween.tween_property(self, 'rotation', PI/28, 0.5)

	tween.tween_callback(cool_rotation_back)
	
func cool_rotation_back():
	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()

	#tween.tween_property(self, 'rotation', -PI/28, 0.5)
	#tween.tween_property(self, 'rotation', PI/28, 0.5)
	#tween.tween_property(self, 'rotation', -PI/28, 0.5)
	#tween.tween_property(self, 'rotation', PI/28, 0.5)
	
	tween.tween_callback(cool_rotation)
