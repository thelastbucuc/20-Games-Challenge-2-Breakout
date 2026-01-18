extends Control


const BALL = preload("uid://brw33lvwy03yi")


@onready var score_label: Label = $MC/ScoreLabel
@onready var high_score_label: Label = $MC/HighScoreLabel
@onready var lives_label: Label = $MC/LivesLabel
@onready var menu: Control = $Menu
@onready var menu_label: Label = $Menu/Menu/VB/MenuLabel
@onready var menu_score_label: Label = $Menu/Menu/VB/HB/ScoreVB/MenuScoreLabel
@onready var menu_high_score_label: Label = $Menu/Menu/VB/HB/HighScoreVB/MenuHighScoreLabel


var _score: int = 0
var _lives: int = 3


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		pause_game()


func _enter_tree() -> void:
	SignalHub.on_point_scored.connect(on_point_scored)
	SignalHub.on_ball_missed.connect(on_ball_missed)
	SignalHub.on_game_over.connect(on_game_over)
	SignalHub.on_game_completed.connect(on_game_completed)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	on_point_scored(0)


func pause_game() -> void:
	if get_tree().paused == false:
		menu.show()
		get_tree().paused = true
	else:
		menu.hide()
		get_tree().paused = false


func generate_ball() -> void:
	var b = BALL.instantiate()
	get_parent().call_deferred("add_child", b)


func on_ball_missed() -> void:
	_lives -=1 
	lives_label.text = "Lives: " + str(_lives)
	if _lives > 0:
		generate_ball()
	else:
		SignalHub.emit_on_game_over()


func on_point_scored(amount: int) -> void:
	_score += amount
	score_label.text = "Score: " + str(_score)
	menu_score_label.text = str(_score)
	if _score > ScoreManager.high_score:
		ScoreManager.high_score = _score
	high_score_label.text = "High Score: " + str(ScoreManager.high_score)
	menu_high_score_label.text = str(ScoreManager.high_score)


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()


func on_game_over() -> void:
	menu_label.text = "GAME\n OVER!"
	pause_game()


func on_game_completed() -> void:
	menu_label.text = "You\n win!"
	pause_game()


func _on_pause_button_pressed() -> void:
	pause_game()
