extends TextureButton
var upgrade_effect
var upgrade_image
var upgrade
var player
var upgrade_ui
var upgrade_description
var upgrade_level
var upgrade_index
var upgrade_json
@onready var main_map = get_tree().get_first_node_in_group('main_map')
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	upgrade_json = main_map.upgrades
	player = get_tree().get_first_node_in_group('player')
	upgrade_ui = get_tree().get_first_node_in_group('upgrade_menu')
	upgrade_index = randi() % upgrade_json.size()
	upgrade = upgrade_json[upgrade_index] 
	upgrade_image = upgrade['image']
	upgrade_effect = upgrade['effect']
	upgrade_level = upgrade['level']
	upgrade_description = upgrade['description']
	var image = load(upgrade_image)
	$TextureRect.texture = image
	$Title.text = upgrade_effect.replace('_', ' ')
	$Description.text = upgrade_description
	$Level.text = str(upgrade_level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_down() -> void:
	player.upgrade(upgrade)
	upgrade_ui.hide()
	upgrade_ui.clear_grid()
	upgrade_level += 1
	upgrade_json[upgrade_index]['level'] += 1
	
	
	
