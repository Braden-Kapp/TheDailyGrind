extends Node2D
signal finished
signal fail
var pressable = false;

func end_game():
	emit_signal("finished")

func failed_game():
	emit_signal("fail")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Spacebar"):
		if pressable:
			get_node("KISS").playing = true
			end_game();


func _on_area_2d_area_entered(area: Area2D) -> void:
	pressable = true;


func _on_area_2d_area_exited(area: Area2D) -> void:
	pressable = false;


func _on_timer_timeout() -> void:
	failed_game();
