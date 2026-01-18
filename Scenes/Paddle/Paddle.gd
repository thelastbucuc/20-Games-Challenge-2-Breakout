extends CharacterBody2D


class_name Paddle


const PLAYER_SPEED: float = 200.0
const GROUP_NAME: String = "paddle"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group(GROUP_NAME)
	SignalHub.on_touched_ceiling.connect(on_touched_ceiling)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.x = PLAYER_SPEED * get_input()
	move_and_slide()


func get_input() -> float:
	return Input.get_axis("left", "right")


func on_touched_ceiling() -> void:
	print("on_touched_ceiling")
