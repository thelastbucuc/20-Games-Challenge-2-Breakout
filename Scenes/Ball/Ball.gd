extends CharacterBody2D


const SPEED_MULT: float = 10
const MARGIN: float = 30


var _speed : float = 400.0
var _can_launch: bool = true
var _player_ref: Paddle


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("launch") and _can_launch == true:
		_can_launch = false
		var _rand_x_dir: float = randf_range(-1, 1)
		velocity = Vector2(_rand_x_dir, -1).normalized() * _speed


func _ready() -> void:
	_player_ref = get_tree().get_first_node_in_group(Paddle.GROUP_NAME)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if _can_launch == true:
		global_position = Vector2(_player_ref.global_position.x, _player_ref.global_position.y - MARGIN)
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider: Object = collision.get_collider()
		if collider.is_in_group(Paddle.GROUP_NAME):
			var paddle_width = collider.get_node("CollisionShape2D").shape.size.x
			var relative_collision_x = (global_position.x - collider.global_position.x) / (paddle_width / 2)
			if abs(relative_collision_x) < 0.2:
				relative_collision_x = 0.2 if relative_collision_x >= 0 else -0.2
			relative_collision_x = clampf(relative_collision_x, -0.8, 0.8)
			var new_direction = Vector2(relative_collision_x, -1).normalized()
			velocity = new_direction * _speed
		elif collider.is_in_group(Brick.GROUP_NAME):
			collider.queue_free()
			SignalHub.emit_on_point_scored(collider._points)
			_speed += SPEED_MULT
			_speed = min(_speed, 800.0)
			velocity = velocity.bounce(collision.get_normal())
			velocity = velocity.normalized() * _speed
		elif global_position.y < 20:
			SignalHub.emit_on_touched_ceiling()
			velocity = velocity.bounce(collision.get_normal())
		else:
			velocity = velocity.bounce(collision.get_normal())


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	SignalHub.emit_on_ball_missed()
	queue_free()
