extends Node2D
signal finished
signal fail

var count = 0

func end_game():
	emit_signal("finished")

func failed_game():
	emit_signal("fail")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Spacebar"):
		if(count < 7):
			get_node("Chomp").playing = true
		if (count == 1):
			playAnimation()
		count = count + 1
	if(count == 1):
		get_node("Burger/B1").visible = false
	if(count == 2):
		get_node("Burger/B2").visible = false
	if(count == 3):
		get_node("Burger/B3").visible = false
	if(count == 4):
		get_node("Burger/B4").visible = false
	if(count == 5):
		get_node("Burger/B5").visible = false
	if(count == 6):
		get_node("Burger/B6").visible = false
	if(count >= 7):
		get_node("Burger/B7").visible = false
		get_node("People/Croc").stop()
		get_node("People/Otter").stop()
		end_game() 

func playAnimation():
	get_node("People/Croc").play("default")
	get_node("People/Otter").play("default")


func _on_timer_timeout() -> void:
	failed_game()
