extends Node2D

func _on_button_button_up() -> void:
	get_tree().change_scene_to_file("res://Worlds/MainMap.tscn")


func _on_button_3_button_down() -> void:
	$Control/Instructions.show()
	pass # Replace with function body.
