@tool
extends Node2D

@onready var skeleton := $Skeleton2D
@onready var curve : Curve2D = $Path2D.curve


func _process(delta: float) -> void:
	for i in skeleton.get_bone_count():
		var bone : Bone2D = skeleton.get_bone(i)
		var point : Vector2 = bone.global_position
		curve.set_point_position(i, to_local(point))
