extends Node2D
signal finished
signal fail

func end_game():
	emit_signal("finished")

func failed_game():
	emit_signal("fail")

func _ready() -> void:
	var rand = randi_range(0,2)
	if(rand == 0):
		get_node("Background2").queue_free()
		get_node("Background3").queue_free()
		get_node("CharacterBody2D").position = Vector2(420, 189)
		
	if(rand == 1):
		get_node("Background1").queue_free()
		get_node("Background3").queue_free()
		get_node("CharacterBody2D").position = Vector2(420, 114)
	if(rand == 2):
		get_node("Background1").queue_free()
		get_node("Background2").queue_free()
		get_node("CharacterBody2D").position = Vector2(328, 263)


func _on_timer_timeout() -> void:
	failed_game()
