extends Node2D
signal finished
signal fail

func end_game():
	await get_tree().create_timer(.3).timeout
	get_node("Clink").playing = false
	emit_signal("finished")

func failed_game():
	await get_tree().create_timer(.3).timeout
	get_node("Clink").playing = false
	emit_signal("fail")
