extends Node2D
signal finished
signal fail
var nextChar
var word
var price
var current = 0

func end_game():
	emit_signal("finished")

func failed_game():
	emit_signal("fail")


func _ready() -> void:
	var rand = randi_range(0,2)
	if rand == 0: #2897
		word = '2897_'
		nextChar = '2'
		price = $Price1
		price.visible = true
	
	if rand == 1: #2897
		word = '9999_'
		nextChar = '9'
		price = $Price2
		price.visible = true
		
	if rand == 2: #2897
		word = '0819_'
		nextChar = '0'
		price = $Price3
		price.visible = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("2"):
		if(nextChar == '2'):
			numVisiblity()
			current += 1
			nextChar = word[current]
	if Input.is_action_just_pressed("8"):
		if(nextChar == '8'):
			numVisiblity()
			current += 1
			nextChar = word[current]
	if Input.is_action_just_pressed("9"):
		if(nextChar == '9'):
			numVisiblity()
			current += 1
			nextChar = word[current]
	if Input.is_action_just_pressed("7"):
		if(nextChar == '7'):
			numVisiblity()
			current += 1
			nextChar = word[current]
	if Input.is_action_just_pressed("0"):
		if(nextChar == '0'):
			numVisiblity()
			current += 1
			nextChar = word[current]
	if Input.is_action_just_pressed("1"):
		if(nextChar == '1'):
			numVisiblity()
			current += 1
			nextChar = word[current]
	if current == 4:
		end_game()

func numVisiblity():
	if current == 0:
		price.get_node("1").visible = true
	elif current ==1:
		price.get_node("2").visible = true
	elif current ==2:
		price.get_node("3").visible = true
	elif current ==3:
		price.get_node("4").visible = true
		


func _on_timer_timeout() -> void:
	failed_game()
