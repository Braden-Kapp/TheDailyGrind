extends Node2D
signal finished
signal fail
var pressableA
var pressableD

var aCount=0
var dCount=0
var gameOver = false

func end_game():
	emit_signal("finished")

func failed_game():
	emit_signal("fail")
	
func _process(delta: float) -> void:
	if gameOver:
		return
	if Input.is_action_just_pressed("A"):
		if pressableA:
			aCount += 1
			get_node("CSing").playing = true
			if (get_node("Sprites/Otter").visible == true):
				get_node("Sprites/Both").visible = true
			else:
				get_node("Sprites/Croc").visible = true
	if Input.is_action_just_pressed("D"):
		if pressableD:
			dCount += 1
			get_node("OSing").playing = true
			if (get_node("Sprites/Croc").visible == true):
				get_node("Sprites/Both").visible = true
			else:
				get_node("Sprites/Otter").visible = true
	if(aCount == 3 && dCount == 3):
		gameOver = true
		await get_tree().create_timer(.55).timeout
		end_game()

func _on_areaA_entered(area: Area2D) -> void:
	pressableA = true

func _on_areaA_exited(area: Area2D) -> void:
	pressableA = false
	get_node("Sprites/Croc").visible = false
	if(get_node("Sprites/Both").visible == true):
		get_node("Sprites/Both").visible = false
	
func _on_areaD_entered(area: Area2D) -> void:
	pressableD = true


func _on_areaD_exited(area: Area2D) -> void:
	pressableD = false
	get_node("Sprites/Otter").visible = false
	if(get_node("Sprites/Both").visible == true):
		get_node("Sprites/Both").visible = false


func _on_timer_timeout() -> void:
	failed_game()
