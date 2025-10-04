extends Node

@export var dialogue_json : JSON

var dialogue_queue = [] #this queues the relevant dialogue

var dialogue_playing = false

var random_dialogue : Array
var story_dialogue : Array

var random_dialogue_selection_enabled = true


func _ready() -> void:
	if dialogue_json == null:
		dialogue_json = preload("res://Dialogue/Dialogue.json")

func _process(delta: float) -> void:
	dialogue_queue_logic()

func dialogue_queue_logic() -> void:
	if dialogue_playing:
		pass
