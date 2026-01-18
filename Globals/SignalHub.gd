extends Node

signal on_point_scored(amount: int)
signal on_lives_changed(amount: int)
signal on_touched_ceiling

func emit_on_point_scored(amount: int):
	on_point_scored.emit(amount)

func emit_on_lives_changed(amount: int):
	on_lives_changed.emit(amount)

func emit_on_touched_ceiling():
	on_touched_ceiling.emit()
