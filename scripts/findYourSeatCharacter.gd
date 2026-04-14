extends CharacterBody2D

var LMove = true
var RMove = true
var UMove = true
var DMove = true

func _ready() -> void:
	pass
func _physics_process(delta: float) -> void:
	LMove = $Left.has_overlapping_areas()
	UMove = $Up.has_overlapping_areas()
	DMove = $Down.has_overlapping_areas()
	RMove = $Right.has_overlapping_areas()
	checkGoal()
	
	if Input.is_action_just_pressed("W"):
		if(UMove != true):
			position.y -= 75 
	if Input.is_action_just_pressed("A"):
		if(LMove != true):
			position.x -= 88
	if Input.is_action_just_pressed("S"):
		if(DMove != true):
			position.y += 75 
	if Input.is_action_just_pressed("D"):
		if(RMove != true):
			position.x += 88  

func checkGoal():
	if($Goal.has_overlapping_areas()):
		get_parent().end_game()
