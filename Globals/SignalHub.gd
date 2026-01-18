extends Node

signal on_point_scored(amount: int)
signal on_ball_missed
signal on_touched_ceiling

func emit_on_point_scored(amount: int):
	on_point_scored.emit(amount)

func emit_on_ball_missed():
	on_ball_missed.emit()

func emit_on_touched_ceiling():
	on_touched_ceiling.emit()
