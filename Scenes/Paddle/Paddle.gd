extends CharacterBody2D


const PLAYER_SPEED: float = 200.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	update_movement()


func update_movement() -> void:
	velocity.x = PLAYER_SPEED * get_input()
	move_and_slide()


func get_input() -> float:
	return Input.get_axis("left", "right")
