extends Node

var dialogue_json

@onready var key_icon = $ReceivingCall/KeyIconUI

var dialogue_queue = [] #this queues the relevant dialogue

var is_dialogue_playing = false

var random_dialogue : Array
var story_dialogue : Array

var random_dialogue_selection_enabled = true

var difficulty_level = 1
var current_pressed_level = 1

func _ready() -> void:
	if dialogue_json == null:
		dialogue_json = JSON.parse_string(FileAccess.get_file_as_string("res://Dialogue/Dialogue.json"))
		
		random_dialogue = dialogue_json['random']
		story_dialogue = dialogue_json['story']
	

func _process(delta: float) -> void:
	dialogue_queue_logic()

func add_to_dialogue_queue(scene):
	dialogue_queue.append(scene)

func play_dialogue_event(scene):
	is_dialogue_playing = true
	current_pressed_level = 1
	$ReceivingCall.visible = true
	$AnimationPlayer.play("ringing_animation")

func dialogue_queue_logic() -> void:
	if not is_dialogue_playing:
		var next_scene = dialogue_queue.pop_front()
		if next_scene == null: return
		
		play_dialogue_event(next_scene)

func start_key_qte() -> void:
	$ReceivingCall.visible = true
	key_icon.qte_start(5)

func qte_passed() -> void:
	$AnimationPlayer.play("qte_passed")
	
func start_main_dialogue() -> void:
	is_dialogue_playing = false
	pass

func _on_random_event_timer_timeout() -> void:
	var random_dialogue_choice = random_dialogue.pick_random()
	add_to_dialogue_queue(random_dialogue_choice)
