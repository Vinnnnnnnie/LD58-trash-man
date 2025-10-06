extends Control

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
		$CharacterLogo.play("Joel")
	elif  scene_logo == 'Joels Wife':
		$CharacterLogo.play("Wife")
	elif scene_logo == 'The Rat':
		$CharacterLogo.play("RatMan")
	
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
