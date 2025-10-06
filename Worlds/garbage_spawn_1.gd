extends Area2D
@export var garbageScene = PackedScene
var garbage_instance
var rand_point
var x
var y
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	x = randi_range(self.position.x - $CollisionShape2D.shape.radius, self.position.x + $CollisionShape2D.shape.radius,)
	y = randi_range(self.position.y - $CollisionShape2D.shape.radius, self.position.y + $CollisionShape2D.shape.radius,)
	rand_point = global_position + Vector2(x,y)
	print('Spawning Garbage')
	garbage_instance = garbageScene
	var garbage = garbage_instance.instantiate()
	garbage.global_position = rand_point
	self.add_child(garbage)
	
	

	pass # Replace with function body.
