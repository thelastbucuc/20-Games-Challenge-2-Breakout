extends Control


const BALL = preload("uid://brw33lvwy03yi")


@onready var score_label: Label = $MC/ScoreLabel
@onready var high_score_label: Label = $MC/HighScoreLabel
@onready var lives_label: Label = $MC/LivesLabel


var _score: int = 0
var _lives: int = 3


func _enter_tree() -> void:
	SignalHub.on_point_scored.connect(on_point_scored)
	SignalHub.on_ball_missed.connect(on_ball_missed)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	high_score_label.text = "High Score: " + str(ScoreManager.high_score)
	


func generate_ball() -> void:
	var b = BALL.instantiate()
	get_parent().call_deferred("add_child", b)


func on_ball_missed() -> void:
	_lives -=1 
	lives_label.text = "Lives: " + str(_lives)
	if _lives > 0:
		generate_ball()


func on_point_scored(amount: int) -> void:
	_score += amount
	score_label.text = "Score: " + str(_score)
