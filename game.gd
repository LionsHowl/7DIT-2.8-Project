extends Node2D

signal start
signal wave_2
signal wave_3
signal quit

var mob_banished
var wave
var menu = "yes"


func _enter_tree():
	get_tree().paused = true


func _on_menu_start():
	wave = 1
	mob_banished = 0
	menu = "no"
	
	%"Fade Headings".one()


func _on_ghost_banished(): 
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


func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		if get_tree().paused != true and menu == "no":
			quit.emit()


func _on_fade_headings_animation_finished(anim_name):
	get_tree().paused = false
	if anim_name == "Wave 1":
		start.emit()
	elif anim_name == "Wave 2":
		wave_2.emit()
	elif anim_name == "Wave 3":
		wave_3.emit()
