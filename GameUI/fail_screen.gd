extends Control

@onready var player = get_tree().get_first_node_in_group('player')

func _ready() -> void:
	pass
	
func start_fail_game():
	$Score.text = str(player.score)
	$AnimationPlayer.play("EndGameAnim")

func _on_retry_button_up() -> void:
	get_tree().reload_current_scene()

func _on_quit_button_up() -> void:
	get_tree().change_scene_to_file("res://Worlds/MainMenu.tscn")
