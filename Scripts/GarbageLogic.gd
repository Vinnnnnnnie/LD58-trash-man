extends Node2D

var getting_sucked = false
var sucking_force = 4
@export var player_vacuum : Area2D
var vacuum_dir

func _ready() -> void:
	if player_vacuum == null:
		player_vacuum = get_tree().get_first_node_in_group('player_vacuum')

func _physics_process(delta: float) -> void:
	if getting_sucked:
		vacuum_dir = player_vacuum.global_position - global_position
		global_position = global_position + vacuum_dir * sucking_force * delta
