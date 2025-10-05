extends Node2D

var getting_sucked = false
var sucking_force = 3
@export var player_vacuum : Area2D
var vacuum_dir
var player

var suck_in_distance = 10

signal sucked_in_garbage

func _ready() -> void:
	if player_vacuum == null:
		player_vacuum = get_tree().get_first_node_in_group('player_vacuum')
	player = get_tree().get_first_node_in_group('player')
	#connect('sucked_in_garbage', get_parent().get_node("/car")._on_garbage_sucked_in_garbage())

func _physics_process(delta: float) -> void:
	if getting_sucked:
		vacuum_dir = player_vacuum.global_position - global_position
		global_position = global_position + vacuum_dir * sucking_force * delta
		
		var distance_to_vacuum = vacuum_dir.length()
		if distance_to_vacuum < suck_in_distance:
			emit_signal("sucked_in_garbage")

func _on_sucked_in_garbage() -> void:
	$GarbageNoise.play()
	player.garbage_sucked()
	player_vacuum.get_node("../../../../../../../../../").create_suck_in_effect()
	queue_free()
