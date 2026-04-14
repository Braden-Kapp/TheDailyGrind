extends Node2D
signal finished
signal fail

func end_game():
	emit_signal("finished")

func failed_game():
	emit_signal("fail")

func _ready() -> void:
	pass 


func _process(delta: float) -> void:
	if (Input.is_action_pressed("W") && get_node("Letter/W").visible == true):
		get_node("Letter/W").visible = false
		get_node("Letter/D").visible = true
		get_node("CoffeeColor/C5").visible = false
	elif (Input.is_action_pressed("D") && get_node("Letter/D").visible == true):
		get_node("Letter/D").visible = false
		get_node("Letter/S").visible = true
		get_node("CoffeeColor/C4").visible = false
	elif (Input.is_action_pressed("S") && get_node("Letter/S").visible == true):
		get_node("Letter/S").visible = false
		get_node("Letter/A").visible = true
		get_node("CoffeeColor/C3").visible = false
	elif (Input.is_action_pressed("A") && get_node("Letter/A").visible == true):
		get_node("Letter/A").visible = false
		get_node("CoffeeColor/C2").visible = false
		end_game()
	


func _on_timer_timeout() -> void:
	failed_game()
