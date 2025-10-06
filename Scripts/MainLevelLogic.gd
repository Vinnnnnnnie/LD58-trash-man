extends Node2D

@onready var player = $car
@onready var dialogue_system = get_tree().get_first_node_in_group('dialogue_system')
@onready var upgrade_menu = get_tree().get_first_node_in_group('upgrade_menu')
@onready var story_dialogue = dialogue_system.story_dialogue

var introduction_difficulty = 1
var story_sequence_number = 1

func _ready() -> void:
	dialogue_system.add_story_dialogue_to_queue(['Introduction'])
	
func _process(delta: float) -> void:
	pass

func _on_car_dumped_garbage(amount_dumped: Variant) -> void:
	pass # Replace with function body.
