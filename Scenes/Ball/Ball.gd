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
	move_and_collide(velocity * delta)
