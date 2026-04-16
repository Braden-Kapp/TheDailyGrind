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
	if(await Day1()== true):
		get_node("Sleep/NightLabel").text = "Day 2 Done!!!\n You're doing\n great"
		if(await Day2() == true):
			get_node("Sleep/NightLabel").text = "Day 3 is OVER!\n DON'T\n BURN OUT"
			if(await Day3() == true):
				await Burnout()

func Day1():
	first = true
	if(await playSchool() == true):
		await playSleep()
		return true
	return false
	
func Day2():
	if(await playSchool() == true):
		if(await playWork() == true):
			await playSleep()
			return true
	return false
func Day3():
	if(await playSchool() == true):
		if(await playWork() == true):
			if(await playDateNight() == true):
				await playSleep()
				return true
	return false

func Burnout():
	var conti = true
	var last = -1
	while(conti):
		var r= randi_range(0,2)
		if(r==last):
			r=r+1
		get_node("GameMusic/MusicDate").pitch_scale += 0.05
		get_node("GameMusic/MusicSchool").pitch_scale += 0.05
		get_node("GameMusic/MusicWork").pitch_scale += 0.05
		select.currentTimer = select.currentTimer - .5
		if(r==0):
			conti = await playSchool()
		if(r==1):
			conti = await playWork()
		if(r==2):
			conti = await playDateNight()
		last = r

func playWork():
	get_node("GameMusic/MusicWork").playing = true
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
		await get_tree().create_timer(.4).timeout
		await instructions("work",array[(r+i)%3])
		await get_tree().create_timer(1.6).timeout
		instructionsDisappear()
		transitionReset()
		select.load_minigame(array[(r+i)%3])
		await select.miniEnd#waits for signal!!!!
		if(select.lives == 0): #ENDGAME
			get_node("GameMusic/MusicWork").playing = false
			playEnd()
			return false
		await get_tree().create_timer(1.2).timeout
		transitionWork()
		await get_tree().create_timer(1.5).timeout
	get_node("GameMusic/MusicWork").playing = false
	return true
	

func playSchool():
	get_node("GameMusic/MusicSchool").playing = true
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
		await get_tree().create_timer(.4).timeout
		await instructions("school",array[(r+i)%4])
		await get_tree().create_timer(1.6).timeout
		instructionsDisappear()
		transitionReset()
		select.load_minigame(array[(r+i)%4])
		await select.miniEnd#waits for signal!!!!
		if(select.lives == 0): #ENDGAME
			get_node("GameMusic/MusicSchool").playing = false
			playEnd()
			return false
		await get_tree().create_timer(1.2).timeout
		transitionSchool()
		await get_tree().create_timer(1.5).timeout
	get_node("GameMusic/MusicSchool").playing = false
	return true

func playDateNight():
	get_node("GameMusic/MusicDate").playing = true
	var array = [
	"res://scenes//MGChooseTheRightRock.tscn",
	"res://scenes//MGKissTheDate.tscn", 
	"res://scenes//MGEatYourFood.tscn",
	"res://scenes//MGSingKaroke.tscn"
	]
	var r = randi_range(0,3)
	transitionDate()
	await get_tree().create_timer(1.5).timeout
	if(first):
		transitionHud()
		get_node("Score").visible = true
		first =false
	for i in range(4):
		await get_tree().create_timer(.4).timeout
		await instructions("date",array[(r+i)%4])
		await get_tree().create_timer(1.6).timeout
		instructionsDisappear()
		transitionReset()
		select.load_minigame(array[(r+i)%4])
		await select.miniEnd#waits for signal!!!!
		if(select.lives == 0): #ENDGAME
			get_node("GameMusic/MusicDate").playing = false
			playEnd()
			return false
		await get_tree().create_timer(1.2).timeout
		transitionDate()
		await get_tree().create_timer(1.5).timeout
	get_node("GameMusic/MusicDate").playing = false
	return true
	
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
	
func playEnd():
	aniPlayer.play("END")
	await get_tree().create_timer(.4).timeout
	get_node("END/EndSong").playing = true
	await get_tree().create_timer(1.5).timeout
	get_node("END/BigScore").text = "Points: " + str(select.score)
	get_node("END/ConSprite").visible = true
	get_node("END/ConLabel").visible = true
	get_node("Score").visible = false
	get_node("END/BigScore").visible = true
	get_node("END/Continue").disabled = false
	get_node("Transitions/School").position = Vector2(240,-160)
	get_node("Transitions/Work").position = Vector2(240,-160)
	get_node("Transitions/Date").position = Vector2(240,-160) 
	

func _on_main_theme_finished() -> void:
	mainTheme.playing = true


func _on_continue_pressed() -> void:
	#CLEANUP
	get_node("GameMusic/MusicDate").pitch_scale = 1
	get_node("GameMusic/MusicSchool").pitch_scale = 1
	get_node("GameMusic/MusicWork").pitch_scale = 1
	get_node("END/EndSong").playing = false
	mainTheme.playing = true
	get_node("END/BigScore").visible = false
	get_node("END/Continue").disabled = true
	get_node("END/ConSprite").visible = false
	get_node("END/ConLabel").visible = false
	get_node("Huds/H2").visible = false
	get_node("Huds/H1").visible = false
	get_node("Huds/H0").visible = false
	hudPlayer.play("RESET")
	get_node("Score").visible = false
	select.score = 0
	get_node("Score").text ="Points: " + str(select.score)
	select.lives = 3
	
	aniPlayer.play("ENDOUT")
	await get_tree().create_timer(1.5).timeout
	get_node("StartScreen/Play").disabled = false 
	
func instructions(type,game):
	if type == "work":
		get_node("Instructions/Title").text = "Time For Work"
		if game == "res://scenes//MGFillTheCup.tscn":
			get_node("Instructions/GameName").text = "FILL THAT CUP"
			get_node("Instructions/SPACE").visible = true
		if game == "res://scenes//MGGiveBackChange.tscn":
			get_node("Instructions/NUMS").visible = true
			get_node("Instructions/GameName").text = "GIVE BACK CHANGE"
		if game == "res://scenes//MGStirTheCoffee.tscn":
			get_node("Instructions/WASD").visible = true
			get_node("Instructions/GameName").text = "STIR THAT COFFEE"
	if type == "school":
		get_node("Instructions/Title").text = "It's School Time"
		if game == "res://scenes//MGAnswerTheQuestion.tscn":
			get_node("Instructions/SPACE").visible = true
			get_node("Instructions/GameName").text = "ANSWER THE QUESTION"
		if game == "res://scenes//MGFillOutTheExam.tscn":
			get_node("Instructions/Mouse").visible = true
			get_node("Instructions/GameName").text = "FILL OUT THE EXAM"
		if game == "res://scenes//MGFindYourSeat.tscn":
			get_node("Instructions/WASD").visible = true
			get_node("Instructions/GameName").text = "FIND YOUR SEAT"
		if game == "res://scenes//MGLabWork.tscn":
			get_node("Instructions/A").visible = true
			get_node("Instructions/D").visible = true
			get_node("Instructions/GameName").text = "CATCH THE DROPS"
	if type == "date":
		get_node("Instructions/Title").text = "Date Night!"
		if game == "res://scenes//MGChooseTheRightRock.tscn":
			get_node("Instructions/Mouse").visible = true
			get_node("Instructions/GameName").text = "CHOOSE A GIFT"
		if game == "res://scenes//MGKissTheDate.tscn":
			get_node("Instructions/SPACE").visible = true
			get_node("Instructions/GameName").text = "LALALA KISS THE GIRL"
		if game == "res://scenes//MGEatYourFood.tscn":
			get_node("Instructions/SPACE").visible = true
			get_node("Instructions/GameName").text = "EAT YOUR FOOD"
		if game == "res://scenes//MGSingKaroke.tscn":
			get_node("Instructions/A").visible = true
			get_node("Instructions/D").visible = true
			get_node("Instructions/GameName").text = "SING THE SONG"
	get_node("Instructions/Title").visible = true
	get_node("Instructions/GameName").visible = true
	
func instructionsDisappear():
	get_node("Instructions/Title").visible = false
	get_node("Instructions/GameName").visible = false
	get_node("Instructions/WASD").visible = false
	get_node("Instructions/A").visible = false
	get_node("Instructions/D").visible = false
	get_node("Instructions/NUMS").visible = false
	get_node("Instructions/SPACE").visible = false
	get_node("Instructions/Mouse").visible = false

func _on_end_song_finished() -> void:
	get_node("END/EndSong").playing = true


func _on_music_school_finished() -> void:
	get_node("GameMusic/MusicSchool").playing = true
func _on_music_work_finished() -> void:
	get_node("GameMusic/MusicWork").playing = true
func _on_music_date_finished() -> void:
	get_node("GameMusic/MusicDate").playing = true
