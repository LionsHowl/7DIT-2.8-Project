extends Node2D

signal start
signal wave_2
signal wave_3
signal quit
signal endless
signal banish

var mob_banished
var wave
var ghost
var halt = "yes"
var id = 1


func _enter_tree():
	#When the game starts the scene tree gets paused.
	get_tree().paused = true


func _on_menu_start():
	#When the start button in the menu scene is pressed varibles mob_banished
	#is reset and wave is set to 1 the Wave 1 animation plays as well.
	wave = 1
	mob_banished = 0
	
	%"Fade Headings".one()


func _on_ghost_banished(type):
	#If the the player is doing the endless wave then the signal banished is
	#sent to replace the mob that was banished. Then mob_banished is increased
	#depending on what mob was banished. Otherwise if wave does not equal 4
	#then mob_banished is just increased by 1. 
	if wave == 4:
		banish.emit()
		if type == "weak":
			mob_banished += 1
		elif type == "mid":
			mob_banished += 2
		elif type == "strong":
			mob_banished += 3
	else:
		mob_banished += 1
	#If wave is 1 and mob_banished is 6 then wave becomes 2, mob_banished is
	#rest and the Wave 2 animation plays.
	if wave == 1 and mob_banished == 6:
		wave = 2
		mob_banished = 0
		get_tree().paused = true
		
		%"Fade Headings".two()
	#If the wave is 2 and mob_banished is 10 then wave is set to 3,
	#mob_banished is reset and the wave 3 animation plays.
	elif wave == 2 and mob_banished == 10:
		wave = 3
		mob_banished = 0
		get_tree().paused = true
		
		%"Fade Headings".three()
	#If the wave is 3 and mob_banished is 10 then wave becomes 4, mob_banished
	#is set to 38 and the endless animation plays.
	elif wave == 3 and mob_banished == 10:
		wave = 4
		mob_banished = 38
		get_tree().paused = true
		
		%"Fade Headings".endless()


func _process(_delta):
	#If the input map recices a quit command then if the scene tree is not
	#paused and the varible halt equals no then the quit signal is released.
	#And if the scene tree is ever paused then halt is set to yes otherwise it
	#is set to know.
	if Input.is_action_just_pressed("quit"):
		if get_tree().paused != true and halt == "no":
			quit.emit()
	if get_tree().paused == true:
		halt = "yes"
	else:
		halt = "no"


func _on_fade_headings_animation_finished(anim_name):
	#Here when an animation for the headings is finished then the corrisponding
	#signal is released for the corrisponding wave to start.
	get_tree().paused = false
	if anim_name == "Wave 1":
		start.emit()
	elif anim_name == "Wave 2":
		wave_2.emit()
	elif anim_name == "Wave 3":
		wave_3.emit()
	else:
		endless.emit()


func _on_endless_summon():
	#When the signal summon is recived from the node Endless then the program
	#connects the new child of Endless to the signal banished and the varible
	#id is increaced by 1 so that then next child can be connected.
	ghost = get_node("/root/Game/Endless/" + str(id))
	ghost.banished.connect(_on_ghost_banished)
	id += 1
