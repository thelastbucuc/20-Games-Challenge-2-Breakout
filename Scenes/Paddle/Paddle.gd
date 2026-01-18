extends CharacterBody2D


class_name Paddle


const PLAYER_SPEED: float = 200.0
const GROUP_NAME: String = "paddle"


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


var _mouse_control: bool = false
var _target_pos: Vector2


func _input(event):
	if event is InputEventMouseButton and _mouse_control == false:
		_mouse_control = true
	elif Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right"):
		if _mouse_control == true:
			_mouse_control = false
	elif event is InputEventMouseMotion:
		_target_pos = event.position
	elif Input.is_action_just_pressed("launch") or event is InputEventMouseButton:
		SignalHub.emit_on_launch_ball()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group(GROUP_NAME)
	SignalHub.on_touched_ceiling.connect(on_touched_ceiling)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if _mouse_control == true:
		global_position.x = lerpf(global_position.x, _target_pos.x, delta * 20)
	else:
		velocity.x = PLAYER_SPEED * get_input()
	move_and_slide()


func get_input() -> float:
	return Input.get_axis("left", "right")


func on_touched_ceiling() -> void:
	if sprite_2d.scale.x > 10:
		sprite_2d.scale.x -= 10
		collision_shape_2d.shape.size.x -= 10
