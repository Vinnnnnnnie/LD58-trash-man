extends Control

@export var joel_logo = preload("res://Images/ui_art/trashmans_boss_jole_final.png")
@export var wife_logo = preload("res://Images/ui_art/My_Bitch_Wife.png")

var audio_player : AudioStreamPlayer

var dialogue_system
var character_logo

var scenes_to_play : Array
var on_scene : int

signal dialogue_finished

func _ready() -> void:
	dialogue_system = get_tree().get_first_node_in_group('dialogue_system')
	audio_player = $AudioStreamPlayer
	character_logo = $CharacterLogo
	on_scene = 0
 
func change_dialogue(scene_number):
	scenes_to_play = dialogue_system.get_current_scenes()
	var scene_audio = load("res://Sounds/Voices/" + scenes_to_play[0][scene_number]['audio_name'])
	var scene_text = scenes_to_play[0][scene_number]['subtitle']
	var scene_logo = scenes_to_play[0][scene_number]['character']
	
	if scene_logo == 'Joel':
		character_logo.texture = joel_logo
	elif  scene_logo == 'Joels Wife':
		character_logo.texture = wife_logo
	
	$Label.text = scene_text
	audio_player.stream = scene_audio
	audio_player.play()

func start_dialogue():
	change_dialogue(on_scene)

func _on_audio_stream_player_finished() -> void:
	on_scene += 1
	if not len(scenes_to_play[0]) <= on_scene:
		change_dialogue(on_scene)
	else:
		on_scene = 0
		emit_signal("dialogue_finished")
