extends TextureButton
var upgrade_effect
var upgrade_image
var upgrade
var player
var upgrade_ui
const UPGRADES := [
	{
		"image":"res://Images/upgrades/Brake_Upgrade.png",
		"effect":"Brake_Upgrade"
	},
	{
		"image":"res://Images/upgrades/Engine_Upgrade.png",
		"effect":"Engine_Upgrade"
	},
	{
		"image":"res://Images/upgrades/Gearbox_Upgrade.png",
		"effect":"Gearbox_Upgrade"
	},
	{
		"image":"res://Images/upgrades/Speed_Upgrade.png",
		"effect":"Speed_Upgrade"
	},
	{
		"image":"res://Images/upgrades/Steering_Upgrade.png",
		"effect":"Steering_Upgrade"
	},
	{
		"image":"res://Images/upgrades/Storage_Upgrade.png",
		"effect":"Storage_Upgrade"
	},
	{
		"image":"res://Images/upgrades/Suction_Upgrade.png",
		"effect":"Suction_Upgrade"
	},
	{
		"image":"res://Images/upgrades/Boost_Speed_Upgrade.png",
		"effect":"Boost_Speed_Upgrade"
	},
	{
		"image":"res://Images/upgrades/Reverse_Gear_Upgrade.png",
		"effect":"Reverse_Gear_Upgrade"
	}
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var upgrade_json = UPGRADES
	player = get_tree().get_first_node_in_group('player')
	upgrade_ui = get_tree().get_first_node_in_group('upgrade_menu')
	upgrade = upgrade_json[randi() % upgrade_json.size()] 
	upgrade_image = upgrade['image']
	upgrade_effect = upgrade['effect']
	var image = Image.load_from_file(upgrade_image)
	$TextureRect.texture = ImageTexture.create_from_image(image)
	$Title.text = upgrade_effect.replace('_', ' ')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_down() -> void:
	player.upgrade(upgrade)
	upgrade_ui.hide()
	
	
