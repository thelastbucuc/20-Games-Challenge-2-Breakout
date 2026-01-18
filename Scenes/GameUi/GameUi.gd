extends Control


const BALL = preload("uid://brw33lvwy03yi")


@onready var score_label: Label = $MC/ScoreLabel
@onready var high_score_label: Label = $MC/HighScoreLabel
@onready var lives_label: Label = $MC/LivesLabel


var _score: int = 0
var _lives: int = 3


func _enter_tree() -> void:
	SignalHub.on_point_scored.connect(on_point_scored)
	SignalHub.on_lives_changed.connect(on_lives_changed)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	high_score_label.text = "High Score: " + str(ScoreManager.high_score)
	on_lives_changed(0)


func on_lives_changed(amount: int) -> void:
	_lives += amount
	lives_label.text = "Lives: " + str(_lives)
	if amount < 0:
		var b = BALL.instantiate()
		b.global_position = Vector2(179.0, 505.0)
		add_child(b)


func on_point_scored(amount: int) -> void:
	_score += amount
	score_label.text = "Score: " + str(_score)
