extends Node2D

signal wave_2

var mob_banished
var wave


func _enter_tree():
	get_tree().paused = true


func _on_menu_start():
	get_tree().paused = false
	wave = 1
	mob_banished = 0


func _on_ghost_banished(): 
	mob_banished += 1
	if wave == 1 and mob_banished == 6:
		wave = 2
		mob_banished = 0
		
		wave_2.emit()


func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
