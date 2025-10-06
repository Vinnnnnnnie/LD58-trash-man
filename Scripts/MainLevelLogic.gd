extends Node2D

@onready var player = $car
@onready var dialogue_system = get_tree().get_first_node_in_group('dialogue_system')
@onready var upgrade_menu = get_tree().get_first_node_in_group('upgrade_menu')
@onready var timer_menu = get_tree().get_first_node_in_group('timer_menu')
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
		"image":"res://Images/upgrades/Gearbox_Upgrade.png",
		"effect":"Gearbox_Upgrade",
		"description": "Took out a few springs that were too heavy, cut some wires that didn’t do squat. Should go much faster now.",
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
