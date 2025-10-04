extends CharacterBody2D

@export var wheel_base = 70
@export var steering_angle = 15
@export var speed = 300.0
@export var acceleration_power = 600
@export var friction = -55
@export var drag = -0.06
@export var braking = -450
@export var max_speed_reverse = 250


var acceleration = Vector2.ZERO
var steer_direction

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	acceleration = Vector2.ZERO
	get_input()
	apply_friction(delta)
	calculate_steering(delta)
	velocity += acceleration * delta
	
	# As good practice, you should replace UI actions with custom gameplay actions.
	move_and_slide()
func apply_friction(delta):
	if acceleration == Vector2.ZERO and velocity.length() < 50:
		velocity = Vector2.ZERO
	var friction_force = velocity * friction * delta
	var drag_force = velocity * velocity.length() * drag * delta
	acceleration += drag_force + friction_force
func get_input():
	var turn = Input.get_axis('turn_left', 'turn_right')
	steer_direction = turn * deg_to_rad(steering_angle)
	if Input.is_action_pressed("forward"):
		acceleration = transform.x * acceleration_power
	if Input.is_action_pressed(\"backward\"):
		acceleration = transform.x * braking

func calculate_steering(delta):
	var rear_wheel = position - transform.x * wheel_base / 2
	var front_wheel = position + transform.x * wheel_base / 2
	
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	
	var new_heading = rear_wheel.direction_to(front_wheel)
	var d = new_heading.dot(velocity.normalized())
	if d > 0:
		velocity = new_heading * velocity.length()
	if d< 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
	rotation = new_heading.angle()
	
