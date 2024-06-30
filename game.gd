extends Node2D

signal wave_2

var mob_banished = 0
var wave


func _enter_tree():
	get_tree().paused = true


func _on_menu_start():
	get_tree().paused = false
	wave = 1


func _on_ghost_banished(): 
	mob_banished += 1
	if wave == 1 and mob_banished == 6:
		wave = 2
		wave_2.emit()
		mob_banished = 0
