@tool
extends Node2D

@onready var skeleton := $Skeleton2D
@onready var curve : Curve2D = $Path2D.curve
var sucking_force = 4
var suck_in_distance = 10

@export var suck_in_effect_scene : PackedScene

func create_suck_in_effect() -> void:
	var new_effect = suck_in_effect_scene.instantiate()
	
	$Path2D.add_child(new_effect)
	new_effect.start_effect()

func _process(delta: float) -> void:
	for i in skeleton.get_bone_count():
		var bone : Bone2D = skeleton.get_bone(i)
		var point : Vector2 = bone.global_position
		curve.set_point_position(i, to_local(point))

func _on_vacuum_area_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area.get_parent().is_in_group('garbage'):
		area.get_parent().getting_sucked = true
		area.get_parent().sucking_force = sucking_force
		area.get_parent().suck_in_distance = suck_in_distance

func _on_vacuum_area_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	if area == null:
		return
		
	if area.get_parent().is_in_group('garbage'):
		area.get_parent().getting_sucked = false
	
	
