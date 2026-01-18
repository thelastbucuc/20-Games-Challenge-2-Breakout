extends CharacterBody2D


const SPEED_MULT: float = 1.03


var _speed : float = 400.0
var _can_launch: bool = true


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("launch") and _can_launch == true:
		_can_launch = false
		var _rand_x_dir: float = randf_range(-1, 1)
		velocity = Vector2(_rand_x_dir, -1).normalized() * _speed


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider: Object = collision.get_collider()
		if collider.is_in_group(Brick.GROUP_NAME):
			collider.queue_free()
		if collider.is_in_group(Paddle.GROUP_NAME):
			var paddle_width = collider.get_node("CollisionShape2D").shape.size.x
			var relative_collision_x = (global_position.x - collider.global_position.x) / (paddle_width / 2)
			if abs(relative_collision_x) < 0.2:
				relative_collision_x = 0.2 if relative_collision_x >= 0 else -0.2
			relative_collision_x = clampf(relative_collision_x, -0.8, 0.8)
			var new_direction = Vector2(relative_collision_x, -1).normalized()
			velocity = new_direction * _speed
		else:
			velocity = velocity.bounce(collision.get_normal())
	
