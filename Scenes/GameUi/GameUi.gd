extends Control


const BALL = preload("uid://brw33lvwy03yi")


@onready var score_label: Label = $MC/ScoreLabel
@onready var high_score_label: Label = $MC/HighScoreLabel
@onready var lives_label: Label = $MC/LivesLabel
@onready var menu: Control = $Menu
@onready var menu_label: Label = $Menu/Bg2/VB/MenuLabel
@onready var menu_score_label: Label = $Menu/Bg2/VB/HB/ScoreVB/MenuScoreLabel
@onready var menu_high_score_label: Label = $Menu/Bg2/VB/HB/HighScoreVB/MenuHighScoreLabel


var _score: int = 0
var _lives: int = 3


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused == false:
			menu.show()
			get_tree().paused = true
		else:
			menu.hide()
			get_tree().paused = false


func _enter_tree() -> void:
	SignalHub.on_point_scored.connect(on_point_scored)
	SignalHub.on_ball_missed.connect(on_ball_missed)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	high_score_label.text = "High Score: " + str(ScoreManager.high_score)
	menu_high_score_label.text = str(ScoreManager.high_score)


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
	menu_score_label.text = str(_score)


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
