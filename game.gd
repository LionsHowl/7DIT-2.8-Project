extends Node2D

signal start
signal wave_2
signal wave_3
signal quit
signal endless
signal banish

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
	if wave == 4:
		banish.emit()
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
		get_tree().paused = true
		
		%"Fade Headings".endless()


func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		print(1)
		print(get_tree().paused)
		print(menu)
		if get_tree().paused != true and menu == "no":
			print(2)
			quit.emit()
			print(5)


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


func _on_endless_summon(name):
	get_node("/root/Game/Endless/" + name).banished.connect(_on_ghost_banished)
