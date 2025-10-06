extends Area2D
@export var garbageScene = PackedScene
var garbage_instance
var rand_point
var x
var y
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for n in 30:
		make_garbage()

 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	make_garbage()
	
func make_garbage():
	x = randi_range(self.position.x - $CollisionShape2D.shape.radius, self.position.x + $CollisionShape2D.shape.radius)
	y = randi_range(self.position.y - $CollisionShape2D.shape.radius, self.position.y + $CollisionShape2D.shape.radius)
	rand_point = position + Vector2(x,y)
	
	garbage_instance = garbageScene
	var garbage = garbage_instance.instantiate()
	garbage.position = rand_point
	self.add_child(garbage)
