extends Node2D
#STYLE NODES GET CAMEL CASE ALL ELSE USE _SEPERATION
@onready var minigame_container = $minigameContainer
var current_minigame: Node = null
var score = 0
var lives = 3
var currentTimer = 9.0

func load_minigame(path: String):
	# Potentially Remove the current minigame
	# Shouldn't be needed
	if current_minigame:
		current_minigame.queue_free()

	var packed_minigame := load(path) as PackedScene
	if packed_minigame == null:
		#error checkin
		push_error("Failed to load minigame: " + path)
		return

	current_minigame = packed_minigame.instantiate()
	minigame_container.add_child(current_minigame)
	#add the finish signal
	if current_minigame.has_signal("finished"):
		current_minigame.finished.connect(_on_minigame_finished)
	if current_minigame.has_signal("fail"):
		current_minigame.fail.connect(_on_minigame_fail)
	if current_minigame.has_node("Timer"):
		current_minigame.get_node("Timer").wait_time = currentTimer
		current_minigame.get_node("Timer").start()
#Calls Minigame on start
func _ready() -> void:
	load_minigame("res://scenes//MGFillOutTheExam.tscn") #currently used for testing
#PackedScene switch to preload PackedScene here and send it to function
func _on_minigame_finished():
	print("Game finished")
	#remove and free the cur minigame
	score += 100
	current_minigame.queue_free()
	current_minigame = null
	
func _on_minigame_fail():
	print("Game finished")
	#remove and free the cur minigame
	lives -= 1
	current_minigame.queue_free()
	current_minigame = null
#ADD TO ALL MINIGAMES
#signal finished

#func end_game():
#    emit_signal("finished")
#    queue_free()

#To edit vars in future
#To access Nodes

#cannot access:
#@onready variables before _ready() 
#local variables  
