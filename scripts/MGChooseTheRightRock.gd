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
	pass


func _on_correct_pressed() -> void:
	end_game();


func _on_bad_pressed() -> void:
	failed_game();


func _on_b_1_mouse_entered() -> void:
	get_node("B1").position.y -= 20
	get_node("RockUp").playing = true

func _on_b_1_mouse_exited() -> void:
	get_node("B1").position.y += 20


func _on_b_2_mouse_entered() -> void:
	get_node("B2").position.y -= 20
	get_node("RockUp").playing = true

func _on_b_2_mouse_exited() -> void:
	get_node("B2").position.y += 20


func _on_b_3_mouse_entered() -> void:
	get_node("B3").position.y -= 20
	get_node("RockUp").playing = true

func _on_b_3_mouse_exited() -> void:
	get_node("B3").position.y += 20


func _on_b_4_mouse_entered() -> void:
	get_node("B4").position.y -= 20
	get_node("RockUp").playing = true

func _on_b_4_mouse_exited() -> void:
	get_node("B4").position.y += 20


func _on_timer_timeout() -> void:
	failed_game();
