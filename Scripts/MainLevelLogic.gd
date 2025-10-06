extends Node2D

@onready var player = $car
@onready var dialogue_system = get_tree().get_first_node_in_group('dialogue_system')
@onready var upgrade_menu = get_tree().get_first_node_in_group('upgrade_menu')
@onready var timer_menu = get_tree().get_first_node_in_group('timer_menu')
@onready var ui_scene = get_tree().get_first_node_in_group('ui_scene')
@onready var game_music = get_tree().get_first_node_in_group('game_music')
@onready var story_dialogue = dialogue_system.story_dialogue

var upgrades = [{
		"image":"res://Images/upgrades/Brake_Upgrade.png",
		"effect":"Brake_Upgrade",
		"description": "They told me they wouldn’t let the truck back on the road if I didn’t change the break pads.",
		"level":1
	},
	{
		"image":"res://Images/upgrades/Engine_Upgrade.png",
		"effect":"Engine_Upgrade",
		"description": "Joel JR JR taped the gas pedal down last night playing “Hide the Body”. Smart kid. Now you get faster FASTER.",
		"level":1
	},
	{
		"image":"res://Images/upgrades/Speed_Upgrade.png",
		"effect":"Speed_Upgrade",
		"description": "My wife spilled her fancy-schmancy extra strength chest hair glue all over the tires this morning. Oh well, can’t let it go to waste.",
		"level":1
	},
	{
		"image":"res://Images/upgrades/Steering_Upgrade.png",
		"effect":"Steering_Upgrade",
		"description": "This turtle skin wheel grip is snazzy AND useful.",
		"level":1
	},
	{
		"image":"res://Images/upgrades/Storage_Upgrade.png",
		"effect":"Storage_Upgrade",
		"description": "Have some extra body bags from when my great-grand auntie got crushed by that falling piano. You can have them if you offer me a good price.",
		"level":1
	},
	{
		"image":"res://Images/upgrades/Suction_Upgrade.png",
		"effect":"Suction_Upgrade",
		"description": "Buddy got me a military strength jet engine as a congrats for my niece’s fifth wedding. Could bolt it on your truck if you’ve got the cash.",
		"level":1
	},
	{
		"image":"res://Images/upgrades/Sucker_Reach_Upgrade.png",
		"effect":"Sucker_Reach_Upgrade",
		"description": "Found me one of those novelty magnets from cartoons to add more reach to your Sucker!",
		"level":1
	},
	{
		"image":"res://Images/upgrades/Boost_Speed_Upgrade.png",
		"effect":"Boost_Speed_Upgrade",
		"description": "Bought a can of something called N-A-P-A-L-M off my cousin’s dog’s biscuit dealer. Works great mixed with gasoline.",
		"level":1
	},
	{
		"image":"res://Images/upgrades/Reverse_Gear_Upgrade.png",
		"effect":"Reverse_Gear_Upgrade",
		"description": "Caught the end of one of those racing movies tryina watch last night's wrestling. If you could drive backwards like that, you wouldn't have to waste time turning.",
		"level":1
	},
	{
		"image":"res://Images/upgrades/Glasses_Upgrade.png",
		"effect":"Glasses_Upgrade",
		"description": "Found ya some glasses in the sewer. Spat on them to clean them up, you should see better now!",
		"level":1
	}
]

var game_timeout_lines = ["MY GRANNY DRIVES FASTER THAN YOU AND SHE'S A PARAPLEGIC",
						"DO YOU WANT A FASTER TRUCK NEXT TIME? TOUGH LUCK","WE TESTED THIS ON CHIMPANZEES AND THEY DRIVE FASTER THAN YOU",
						"HOW DOES IT FEEL TO BE REPLACED BY A RAT?","MAKE SURE TO TELL YOUR PARENTS THAT YOU'RE A DISAPPOINTMENT",
						"YOU'RE ABOUT AS MUCH USE AS A FISH WITH TITS","YOU THOUGHT WE WERE UGLY YOU LOOK LIKE THE ARTISTS DREW YOU WITH THEIR LEFT HAND!",
						"LOOK AT ALL THIS TRASH JUST LAYIN AROUND! YOU'RE ONE LAZY SON OF A BITCH","MY WIFES ALWAYS GETTING ON AT ME ABOUT BEING LAZY BUT HERES YOU TAKIN FIRST PLACE",
						"I THINK YOU WOULD HAVE A BETTER TIME WORKING AT THAT HAPPY SHOPPER UP THE ROAD AS A FLOOR CLEANER"] 


var introduction_difficulty = 1
var story_sequence_number = 1

var overall_amount_dumped = 0

const time_gained_from_each_garbage = 2.0

func _ready() -> void:
	dialogue_system.add_story_dialogue_to_queue(['Introduction'])
	
	player.connect('dumped_garbage', _on_dumped_garbage)
	
	dialogue_system.connect('phone_ringing_started', _on_phone_ringing_started)
	dialogue_system.connect('phone_answered', _on_phone_answered)
	dialogue_system.connect('phone_call_dialogue_started', _on_phone_call_dialogue_started)
	dialogue_system.connect('phone_call_ended', _on_phone_call_ended)
	dialogue_system.connect('failed_qte', _on_failed_qte)
	
	timer_menu.get_node('Timer').connect('timeout', on_game_timeout)
	
	dialogue_system.difficulty_level = introduction_difficulty
	
func pause_timers() -> void:
	for timer in get_tree().get_nodes_in_group("timer_cutscene_pausable"):
		timer.paused = true
	
func resume_timers() -> void:
	for timer in get_tree().get_nodes_in_group("timer_cutscene_pausable"):
		if timer is AudioStreamPlayer:
			timer.play()
		else:
			timer.paused = false
	
func _process(delta: float) -> void:
	main_game_logic()
	
func main_game_logic() -> void:
	pass
		
func end_game(reason: String = ""):
	pause_timers()
	ui_scene.fail_screen_start(reason)

func clear_barriers(group_name):
	for barrier in get_tree().get_nodes_in_group(group_name):
		barrier.clear_blockade()

# CHECKS PROGRESSION ON GARBAGE DUMP, THIS IS WHERE STORY DIALOGUE GETS PLAYED
func progression_check_logic():
	### FIRST COMBO SEQUENCE <40 TOTAL
	if overall_amount_dumped >= 5 and overall_amount_dumped < 20 and story_sequence_number == 1:
		dialogue_system.add_story_dialogue_to_queue(['Bargaining part 1'])
		story_sequence_number += 1
		clear_barriers('blockade_city')
		
	if overall_amount_dumped >= 20 and overall_amount_dumped < 40 and story_sequence_number == 2:
		dialogue_system.add_story_dialogue_to_queue(['Quit attempt 1'])
		story_sequence_number += 1
	
	### SECOND COMBO SEQUENCE <80 TOTAL
	if overall_amount_dumped >= 40 and overall_amount_dumped < 60 and story_sequence_number == 3:
		dialogue_system.add_story_dialogue_to_queue(['Bargaining part 2'])
		story_sequence_number += 1
		clear_barriers('blockade_park')
		
	if overall_amount_dumped >= 60 and overall_amount_dumped < 80 and story_sequence_number == 4:
		dialogue_system.add_story_dialogue_to_queue(['Quit attempt 2'])
		story_sequence_number += 1
	
	### THIRD COMBO SEQUENCE <120 TOTAL
	if overall_amount_dumped >= 80 and overall_amount_dumped < 100 and story_sequence_number == 5:
		dialogue_system.add_story_dialogue_to_queue(['Bargaining part 3'])
		story_sequence_number += 1
		clear_barriers('blockade_docks')
		
	if overall_amount_dumped >= 100 and overall_amount_dumped < 120 and story_sequence_number == 6:
		dialogue_system.add_story_dialogue_to_queue(['Quit attempt 3'])
		story_sequence_number += 1
	
	### SECOND COMBO SEQUENCE <160 TOTAL
	if overall_amount_dumped >= 120 and overall_amount_dumped < 140 and story_sequence_number == 7:
		dialogue_system.add_story_dialogue_to_queue(['Bargaining part 4'])
		story_sequence_number += 1
		
	if overall_amount_dumped >= 140 and overall_amount_dumped < 160 and story_sequence_number == 8:
		dialogue_system.add_story_dialogue_to_queue(['Quit attempt 4'])
		story_sequence_number += 1
	
func _on_dumped_garbage(amount_dumped: Variant) -> void:
	print('DUMPED: ', amount_dumped)
	overall_amount_dumped += amount_dumped
	
	if amount_dumped > 0:
		timer_menu.gain_time(amount_dumped * time_gained_from_each_garbage)
	
	progression_check_logic()
	
func _on_phone_ringing_started() -> void:
	game_music.volume_db = -32
	if dialogue_system.difficulty_level == 1:
		pause_timers()
	
	print(dialogue_system.difficulty_level)
	
	if dialogue_system.difficulty_level == 1:
		player.paused_player_movement = true
	
	print('phone started')
	
func _on_phone_answered() -> void:
	print('phone answered')
	
func _on_phone_call_dialogue_started() -> void:
	print('yapping begins')
	
func _on_phone_call_ended() -> void:
	game_music.volume_db = -18
	resume_timers()
	print(dialogue_system.difficulty_level)
	
	if dialogue_system.difficulty_level == 1:
		player.paused_player_movement = false
		dialogue_system.difficulty_level += 1
	
	print('yapping ended')
	
func _on_failed_qte() -> void:
	if dialogue_system.difficulty_level == 1:
		end_game("PICK UP THE TUTORIAL PHONE CALL NUMB NUTS")
		
func on_game_timeout() -> void:
	end_game(game_timeout_lines.pick_random())
