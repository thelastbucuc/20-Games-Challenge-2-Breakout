extends Node2D


const BRICK = preload("uid://6go1yaao06g2")
const BALL = preload("uid://brw33lvwy03yi")


@onready var score_label: Label = $CanvasLayer/MC/ScoreLabel
@onready var lives_label: Label = $CanvasLayer/MC/LivesLabel
@onready var high_score_label: Label = $CanvasLayer/MC/HighScoreLabel
@onready var brick_container: Node2D = $BrickContainer


var _score: int = 0
var _lives: int = 3


func _enter_tree() -> void:
	SignalHub.on_point_scored.connect(on_point_scored)
	SignalHub.on_lives_changed.connect(on_lives_changed)
	SignalHub.on_touched_ceiling.connect(on_touched_ceiling)


func _ready() -> void:
	generate_bricks()
	high_score_label.text = "High Score: " + str(ScoreManager.high_score)
	on_lives_changed(0)


func generate_bricks() -> void:
	var row_colors = [Color.RED, Color.ORANGE, Color.YELLOW, Color.GREEN, Color.BLUE]
	var rows = row_colors.size()
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


func on_point_scored(amount: int) -> void:
	_score += amount
	score_label.text = "Score: " + str(_score)


func on_lives_changed(amount: int) -> void:
	_lives += amount
	lives_label.text = "Lives: " + str(_lives)
	if amount < 0:
		var b = BALL.instantiate()
		b.global_position = Vector2(179.0, 505.0)
		add_child(b)


func on_touched_ceiling() -> void:
	print("on_touched_ceiling")
