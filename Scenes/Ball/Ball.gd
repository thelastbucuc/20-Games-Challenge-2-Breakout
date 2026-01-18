extends CharacterBody2D


const SPEED_MULT: float = 1.03


var _speed : float = 400.0
var _can_launch: bool = true
var _rand_x_dir: float = randf_range(-1, 1)
var _launch_velocity: Vector2 = Vector2(_rand_x_dir, -1).normalized() * _speed

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("launch") and _can_launch == true:
		_can_launch = false
		velocity = _launch_velocity


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	update_movement(delta)


func update_movement(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group(Brick.GROUP_NAME):
			collider.queue_free()
		if collider.is_in_group(Paddle.GROUP_NAME):
			var bounce_angle = (global_position.x - collider.global_position.x) / (collider.get_node("CollisionShape2D").shape.get_rect().size.x / 2)
			#bounce_angle = clamp(bounce_angle, -0.7, 0.7)
			var new_direction = Vector2(-velocity.normalized().y, bounce_angle).normalized()
			velocity = new_direction * _speed
		else:
			velocity = velocity.bounce(collision.get_normal())
		_speed *= SPEED_MULT
