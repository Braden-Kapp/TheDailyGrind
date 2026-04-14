extends Node2D
@onready var select = $miniGameSelect

func _ready() -> void:
	pass # Replace with function body.



func _process(delta: float) -> void:
	pass


func _on_play_pressed() -> void:
	get_node("StartScreen/Play").disabled = true
	theDailyGrind()
	
func theDailyGrind():
	Day1()
	Day2()
	Day3()
	Burnout()

func Day1():
	playWork()

func Day2():
	pass

func Day3():
	pass
	
func Burnout():
	pass
	
func playWork():
	select.load_minigame("res://scenes//MGFillTheCup.tscn")
	
func playSchool():
	pass
	
func playDatenight():
	pass
