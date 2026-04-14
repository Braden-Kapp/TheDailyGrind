extends Node2D
signal finished
signal fail

var rand
var count = 0

func end_game():
	emit_signal("finished")

func failed_game():
	emit_signal("fail")


func _ready() -> void:
	rand = randi_range(0,2)
	if(rand == 0):
		get_node("Q1").position = Vector2(269, 105)
		get_node("Q2").position = Vector2(304, 155)
		get_node("Q3").position = Vector2(304, 205)
		get_node("Q4").position = Vector2(339, 255)
	if(rand == 1):
		get_node("Q1").position = Vector2(304, 105)
		get_node("Q2").position = Vector2(304, 155)
		get_node("Q3").position = Vector2(339, 205)
		get_node("Q4").position = Vector2(339, 255)
	if(rand == 2):
		get_node("Q1").position = Vector2(339, 105)
		get_node("Q2").position = Vector2(304, 155)
		get_node("Q3").position = Vector2(304, 205)
		get_node("Q4").position = Vector2(269, 255)

func _process(delta: float) -> void:
	if count == 4:
		end_game()


func _on_q_1_pressed() -> void:
	get_node("Q1/GreySprite").visible = false
	get_node("Q1/RedSprite").visible = true
	count = count + 1
	get_node("Q1").pressed.disconnect(_on_q_1_pressed)


func _on_q_2_pressed() -> void:
	get_node("Q2/GreySprite").visible = false
	get_node("Q2/RedSprite").visible = true
	count = count + 1
	get_node("Q2").pressed.disconnect(_on_q_2_pressed)



func _on_q_3_pressed() -> void:
	get_node("Q3/GreySprite").visible = false
	get_node("Q3/RedSprite").visible = true
	count = count + 1
	get_node("Q3").pressed.disconnect(_on_q_3_pressed)



func _on_q_4_pressed() -> void:
	get_node("Q4/GreySprite").visible = false
	get_node("Q4/RedSprite").visible = true
	count = count + 1
	get_node("Q4").pressed.disconnect(_on_q_4_pressed)


func _on_timer_timeout() -> void:
	failed_game()
