extends TextureButton
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
	
	var upgrade = upgrade_json[randi() % upgrade_json.size()] 
	var upgrade_image = upgrade['image']
	var upgrade_effect = upgrade['effect']
	var image = Image.load_from_file(upgrade_image)
	$TextureRect.texture = ImageTexture.create_from_image(image)
	$Title.text = upgrade_effect.replace('_', ' ')

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
