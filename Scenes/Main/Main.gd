extends Node2D


const BRICK = preload("uid://6go1yaao06g2")


@onready var brick_container: Node2D = $BrickContainer


func _ready() -> void:
	generate_bricks()


func generate_bricks() -> void:
	var row_colors = [Color.RED, Color.ORANGE, Color.YELLOW, Color.GREEN, Color.BLUE]
	var rows = 1#row_colors.size()
	var cols = 7
	var margin = 4
	var offset_x = 35
	var offset_y = 50
	var brick_width = 44
	var brick_height = 12
	for r in rows:
		for c in cols:
			var new_brick: Brick = BRICK.instantiate()
			var x_pos = offset_x + c * (brick_width + margin)
			var y_pos = offset_y + r * (brick_height + margin)
			new_brick.position = Vector2(x_pos, y_pos)
			var color_index = r % row_colors.size()
			new_brick.modulate = row_colors[color_index]
			if r == 0:
				new_brick._points = 50
			elif r == 1:
				new_brick._points = 30
			else:
				new_brick._points = 10
			brick_container.add_child(new_brick)
