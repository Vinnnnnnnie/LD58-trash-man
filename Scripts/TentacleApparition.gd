extends Line2D

@export var path : Path2D

func _process(delta: float) -> void:
	if not path:
		return
	if not path.curve:
		points = []
		return
	points = path.curve.get_baked_points()
	
func _get_configuration_warnings() -> PackedStringArray:
	var warnings = []
	if not path:
		warnings.append("Assign a Path2D node in the path property")
	return warnings
