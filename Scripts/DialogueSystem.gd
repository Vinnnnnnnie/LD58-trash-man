extends Node

var dialogue_json

@onready var key_icon = $ReceivingCall/KeyIconUI
@onready var anim_play = $AnimationPlayer

var dialogue_queue = [] #this queues the relevant dialogue

var is_dialogue_playing = false

var random_dialogue : Array
var random_joel_dialogue : Array
var random_wife_dialogue : Array
var story_dialogue : Array

var random_dialogue_selection_enabled = true

var difficulty_level = 1

var current_scenes_at_play: Array

func _ready() -> void:
	if dialogue_json == null:
		dialogue_json = JSON.parse_string(FileAccess.get_file_as_string("res://Dialogue/Dialogue.json"))
		
		random_dialogue = dialogue_json['random']
		story_dialogue = dialogue_json['story']
		
		for dialogue in random_dialogue:
			if dialogue['character'] == 'Joel':
				random_joel_dialogue.append(dialogue)
			elif dialogue['character'] == 'Joels Wife':
				random_wife_dialogue.append(dialogue)

func _process(delta: float) -> void:
	dialogue_queue_logic()
	
func pause_timer() -> void:
	$RandomEventTimer.paused = true
	
func resume_timer() -> void:
	$RandomEventTimer.paused = false

### CORE DIALOGUE LOGIC

func add_to_dialogue_queue(scenes: Array):
	dialogue_queue.append(scenes)
	
func add_story_dialogue_to_queue(event_names: Array):
	var added_scenes = []
	for event_name in event_names:
		for scene in story_dialogue:
			if event_name == scene['event_name']:
				added_scenes.append(scene)
				break
	add_to_dialogue_queue(added_scenes)

func play_dialogue_event(scenes):
	current_scenes_at_play.append(scenes)
	is_dialogue_playing = true
	$ReceivingCall.visible = true
	anim_play.play("ringing_animation")

func dialogue_queue_logic() -> void:
	if not is_dialogue_playing:
		var next_scene = dialogue_queue.pop_front()
		if next_scene == null: return
		
		play_dialogue_event(next_scene)


### Functions mostly for animations to call from below

func start_key_qte() -> void:
	$ReceivingCall.visible = true
	key_icon.qte_start(difficulty_level)

func qte_passed() -> void:
	$InCall/AudioStreamPlayer.stop()
	anim_play.play("qte_passed")
	
func qte_failed() -> void:
	end_game()
	print('failed qte')
	
func start_main_dialogue() -> void:
	anim_play.play("main_dialogue_start")
	pass

func reset_animation_player() -> void:
	anim_play.play("RESET")
	anim_play.advance(0)
	
func get_current_scenes() -> Array:
	return current_scenes_at_play

func end_dialogue() -> void:
	reset_animation_player()
	current_scenes_at_play = []
	difficulty_level += 1
	is_dialogue_playing = false
	
func end_game():
	get_parent().fail_screen_start()

### Adds on random dialogue after set time by timer
func _on_random_event_timer_timeout() -> void:
	var random_dialogue_joel_and_wife = []
	random_dialogue_joel_and_wife.append(random_joel_dialogue.pick_random())
	random_dialogue_joel_and_wife.append(random_wife_dialogue.pick_random())
	add_to_dialogue_queue(random_dialogue_joel_and_wife)

### Final call when dialogue is finished, plays final animations which ends dialogue
func _on_in_call_dialogue_finished() -> void:
	anim_play.play("main_dialogue_exit")
	
