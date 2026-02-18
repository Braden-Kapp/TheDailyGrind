extends Node2D
signal finished
signal fail

func end_game():
	emit_signal("finished")

func failed_game():
	emit_signal("fail")
