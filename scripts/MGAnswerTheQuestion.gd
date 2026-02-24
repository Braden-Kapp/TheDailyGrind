extends Node2D
signal finished
signal fail

var gameOn = true
var question

func end_game():
	emit_signal("finished")

func failed_game():
	emit_signal("fail")
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	question = randi_range(0,3)
	if(question == 0):
		get_node("Questions/Q1").visible = true
	elif(question == 1):
		get_node("Questions/Q2").visible = true
	elif(question == 2):
		get_node("Questions/Q3").visible = true
	elif(question == 3):
		get_node("Questions/Q4").visible = true
	shuffleAnswers()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Spacebar"):
		if(question ==0 and get_node("Answers/2").visible == true):
			end_game()
		elif(question ==1 and get_node("Answers/4").visible == true):
			end_game()
		elif(question ==2 and get_node("Answers/6").visible == true):
			end_game()
		elif(question ==3 and get_node("Answers/8").visible == true):
			end_game()
		else:
			failed_game()

func shuffleAnswers() -> void:
	while(gameOn):
		await get_tree().create_timer(1).timeout
		get_node("Answers/2").visible = false
		get_node("Answers/4").visible = true
		await get_tree().create_timer(1).timeout
		get_node("Answers/4").visible = false
		get_node("Answers/6").visible = true
		await get_tree().create_timer(1).timeout
		get_node("Answers/6").visible = false
		get_node("Answers/8").visible = true
		await get_tree().create_timer(1).timeout
		get_node("Answers/8").visible = false
		get_node("Answers/2").visible = true


func _on_timer_timeout() -> void:
	failed_game() # Replace with function body.
