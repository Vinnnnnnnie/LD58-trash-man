extends Control

@onready var player = get_tree().get_first_node_in_group('player')
@onready var vacuum = get_tree().get_first_node_in_group('vacuum_scene')

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotation = 0
	pass


func _on_timer_game_over() -> void:
	pass # Replace with function body.

func fail_screen_start() -> void:
	$Score.visible = false
	$CallLayout.visible = false
	$Upgrades.visible = false
	$Timer.visible = false
	$BoostBar.visible = false
	$StorageBar.visible = false
	
	player.game_over = true
	vacuum.process_mode = Node.PROCESS_MODE_DISABLED
	
	$FailScreen.start_fail_game()
