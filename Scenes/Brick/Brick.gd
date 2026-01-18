extends StaticBody2D


class_name Brick


const GROUP_NAME: String = "bricks"


var _points: int = 10


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group(GROUP_NAME)
