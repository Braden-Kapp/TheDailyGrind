extends Node2D
signal finished
signal fail

func end_game():
	emit_signal("finished")

func failed_game():
	emit_signal("fail")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("Spacebar"):
		
		if get_node("PourSound").playing == false:
			get_node("PourSound").playing = true
			
		get_node("But/NotPress").visible = false
		get_node("Pour").visible = true
		get_node("Liquid").scale.y += .05
		#print(get_node("Liquid").scale.y)
		#19.5999889373779
		#22.4999446868896

	else:
		get_node("PourSound").playing = false
		get_node("Pour").visible = false
		get_node("But/NotPress").visible = true
		if get_node("Liquid").scale.y > 19.59 && get_node("Liquid").scale.y < 22.50:
			end_game()
		if get_node("Liquid").scale.y > 22.50:
			failed_game()


func _on_timer_timeout() -> void:
	failed_game()
