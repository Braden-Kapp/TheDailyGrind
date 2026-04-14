extends Node2D
@onready var scoreLabel = get_parent().get_node("Score")
#STYLE NODES GET CAMEL CASE ALL ELSE USE _SEPERATION
@onready var minigame_container = $minigameContainer
var current_minigame: Node = null
var score = 0
var lives = 3
var currentTimer = 9.0
var randVictory= 0
signal miniEnd
var processing = false

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
	updateScore()
	#was for testing
	#load_minigame("res://scenes//MGFillTheCup.tscn") #currently used for testing
#PackedScene switch to preload PackedScene here and send it to function
func updateScore():
	scoreLabel.text = "Points: " + str(score)

func _on_minigame_finished():
	#print("Game finished")
	if processing == true:
		return
	processing = true
	randVictory = randi_range(0,4)
	score += 100
	updateScore()
	
	miniEnd.emit()
	if(randVictory == 0):
		get_node("WinSound/Win1").playing = true
	if(randVictory == 1):
		get_node("WinSound/Win2").playing = true
	if(randVictory == 2):
		get_node("WinSound/Win3").playing = true
	if(randVictory == 3):
		get_node("WinSound/Win4").playing = true
	if(randVictory == 4):
		get_node("WinSound/Win5").playing = true
		
	await get_tree().create_timer(2.8).timeout
	processing = false
	current_minigame.queue_free()
	current_minigame = null
	
func _on_minigame_fail():
	if processing == true:
		return
	processing = true
	print("Game finished")
	#remove and free the cur minigame
	lives -= 1
	if(lives==2):
		get_parent().get_node("Huds/H2").visible = true
	if(lives==1):
		get_parent().get_node("Huds/H1").visible = true
	if(lives==0):
		get_parent().get_node("Huds/H0").visible = true
	miniEnd.emit()
	get_node("FAIL").playing = true
	
	await get_tree().create_timer(2.8).timeout
	processing = false
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
