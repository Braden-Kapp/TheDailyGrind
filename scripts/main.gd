extends Node2D
@onready var select = $miniGameSelect
@onready var aniPlayer =  $Transitions/TransitionPlayer
@onready var hudPlayer =  $Huds/HudTransition
@onready var mainTheme =  $MainTheme
var first =true
func _ready() -> void:
	mainTheme.playing = true
	
func _process(delta: float) -> void:
	pass
	
func _on_play_pressed() -> void:
	get_node("StartScreen/Play").disabled = true #weirdAhhError
	theDailyGrind()
	
func theDailyGrind():
	mainTheme.playing = false
	get_node("Sleep/NightLabel").text = "Day 1 Complete :)\n Get Some Rest"
	await Day1()
	get_node("Sleep/NightLabel").text = "Day 2 Done!!!\n You're doing\n great"
	await Day2()
	get_node("Sleep/NightLabel").text = "Day 3 is OVER!\n DON'T\n BURN OUT"
	await Day3()
	await Burnout()

func Day1():
	first = true
	await playSchool()
	await playSleep()

func Day2():
	await playSchool()
	await playWork()
	await playSleep()

func Day3():
	await playSchool()
	await playWork()
	await playDateNight()
	await playSleep()
	
func Burnout():
	var r= randi_range(0,2)
	select.currentTimer = select.currentTimer - .5
	if(r==0):
		playSchool()
	if(r==1):
		playWork()
	if(r==2):
		playDateNight()

func playWork():
	var array = [
	"res://scenes//MGFillTheCup.tscn",
	"res://scenes//MGGiveBackChange.tscn", 
	"res://scenes//MGStirTheCoffee.tscn",
	]
	var r = randi_range(0,2)
	transitionWork()
	await get_tree().create_timer(1.5).timeout
	if(first):
		transitionHud()
		get_node("Score").visible = true
		first =false
	for i in range(3):
		await get_tree().create_timer(1.5).timeout
		transitionReset()
		select.load_minigame(array[(r+i)%3])
		await select.miniEnd#waits for signal!!!!
		await get_tree().create_timer(1.2).timeout
		transitionWork()
		await get_tree().create_timer(2.0).timeout
		
	

func playSchool():
	var array = [
	"res://scenes//MGAnswerTheQuestion.tscn",
	"res://scenes//MGFillOutTheExam.tscn", 
	"res://scenes//MGFindYourSeat.tscn",
	"res://scenes//MGLabWork.tscn"
	]
	var r = randi_range(0,3)
	transitionSchool()
	await get_tree().create_timer(1.5).timeout
	if(first):
		transitionHud()
		get_node("Score").visible = true
		first =false
	for i in range(4):
		await get_tree().create_timer(1.5).timeout
		transitionReset()
		select.load_minigame(array[(r+i)%4])
		await select.miniEnd#waits for signal!!!!
		await get_tree().create_timer(1.2).timeout
		transitionSchool()
		await get_tree().create_timer(2.0).timeout
		

func playDateNight():
	var array = [
	"res://scenes//MGChooseTheRightRock.tscn",
	"res://scenes//MGKissTheDate.tscn", 
	"res://scenes//MGKissTheDate.tscn",
	"res://scenes//MGKissTheDate.tscn"
	]
	var r = randi_range(0,3)
	transitionDate()
	await get_tree().create_timer(1.5).timeout
	if(first):
		transitionHud()
		get_node("Score").visible = true
		first =false
	for i in range(4):
		await get_tree().create_timer(1.5).timeout
		transitionReset()
		select.load_minigame(array[(r+i)%4])
		await select.miniEnd#waits for signal!!!!
		await get_tree().create_timer(1.2).timeout
		transitionDate()
		await get_tree().create_timer(2.0).timeout
		
	
func transitionWork():
	aniPlayer.play("Work")
func transitionSchool():
	aniPlayer.play("School")
func transitionDate():
	aniPlayer.play("Date")
func transitionReset():
	aniPlayer.play("RESET")
	
func transitionHud():
	hudPlayer.play("Hud")

func playSleep():
	mainTheme.playing = true
	aniPlayer.play("Sleep")
	await get_tree().create_timer(2).timeout
	get_node("Sleep/NightLabel").visible = true
	get_node("Transitions/School").position = Vector2(240,-160)
	get_node("Transitions/Work").position = Vector2(240,-160)
	get_node("Transitions/Date").position = Vector2(240,-160)
	await get_tree().create_timer(6).timeout
	get_node("Sleep/NightLabel").visible = false
	aniPlayer.play("SleepOut")
	await get_tree().create_timer(2.5).timeout
	mainTheme.playing = false

func _on_main_theme_finished() -> void:
	mainTheme.playing = true
