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
	get_tree().paused = true


func _on_menu_start():
	wave = 1
	mob_banished = 0
	
	%"Fade Headings".one()


func _on_ghost_banished(type):
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
	if wave == 1 and mob_banished == 6:
		wave = 2
		mob_banished = 0
		get_tree().paused = true
		
		%"Fade Headings".two()
	elif wave == 2 and mob_banished == 10:
		wave = 3
		mob_banished = 0
		get_tree().paused = true
		
		%"Fade Headings".three()
	elif wave == 3 and mob_banished == 10:
		wave = 4
		mob_banished = 38
		get_tree().paused = true
		
		%"Fade Headings".endless()


func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		if get_tree().paused != true and halt == "no":
			quit.emit()
	if get_tree().paused == true:
		halt = "yes"
	else:
		halt = "no"


func _on_fade_headings_animation_finished(anim_name):
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
	ghost = get_node("/root/Game/Endless/" + str(id))
	ghost.banished.connect(_on_ghost_banished)
	id += 1
