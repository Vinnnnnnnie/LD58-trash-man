extends Control
@onready var upgrade_card = load("res://GameUI/card.tscn")

var card
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#generate_upgrades()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func generate_upgrades():
	for n in 3:
		var card_instance = upgrade_card.instantiate()
		$Grid.add_child(card_instance)
	
