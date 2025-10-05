extends Node2D

@onready var key_label = $Label
@onready var key_icon = $KeyIcon
@onready var button_press_tone_audio = preload("res://Sounds/Effects/nokia_button.mp3")

@export var label : String = ""

var random_characters : Array

var qte_enabled = false
var difficulty_level

func _ready() -> void:
	random_characters.append_array(['l', 'p', 'i', '9'])
	$AudioStreamPlayer.stream = button_press_tone_audio

func _physics_process(delta: float) -> void:
	if qte_enabled:
		if Input.is_physical_key_pressed(OS.find_keycode_from_string(key_label.text)) and difficulty_level != 0:
			$AudioStreamPlayer.play()
			difficulty_level -= 1
			
			if difficulty_level != 0:
				key_label.text = random_characters.pick_random()
			else:
				key_label.text = ''
			$AnimationTree.play("new_button_label_anim")
		elif difficulty_level == 0:
			get_parent().get_parent().qte_passed()
			print('done')
			qte_enabled = false

func qte_start(difficulty) -> void:
	key_label.text = random_characters.pick_random()
	difficulty_level = difficulty
	visible = true
	qte_enabled = true
