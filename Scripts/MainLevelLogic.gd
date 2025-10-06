extends Node2D

@onready var player = $car
@onready var dialogue_system = get_tree().get_first_node_in_group('dialogue_system')
@onready var upgrade_menu = get_tree().get_first_node_in_group('upgrade_menu')
@onready var timer_menu = get_tree().get_first_node_in_group('timer_menu')
@onready var story_dialogue = dialogue_system.story_dialogue

var introduction_difficulty = 1
var story_sequence_number = 1

var overall_amount_dumped = 0

func _ready() -> void:
	dialogue_system.add_story_dialogue_to_queue(['Introduction'])
	dialogue_system.connect('phone_ringing_started', _on_phone_ringing_started)
	dialogue_system.connect('phone_answered', _on_phone_answered)
	dialogue_system.connect('phone_call_dialogue_started', _on_phone_call_dialogue_started)
	
func pause_timers() -> void:
	for timer in get_tree().get_nodes_in_group("timer_cutscene_pausable"):
		timer.paused = true
	
func resume_timers() -> void:
	for timer in get_tree().get_nodes_in_group("timer_cutscene_pausable"):
		timer.paused = false
	
func _process(delta: float) -> void:
	main_game_logic()
	
func main_game_logic() -> void:
	if dialogue_system.is_dialogue_playing:
		pause_timers()
	else:
		resume_timers()

func _on_car_dumped_garbage(amount_dumped: Variant) -> void:
	overall_amount_dumped += amount_dumped
	
func _on_phone_ringing_started() -> void:
	print('phone started')
	
func _on_phone_answered() -> void:
	print('phone answered')
	
func _on_phone_call_dialogue_started() -> void:
	print('yapping begins')
