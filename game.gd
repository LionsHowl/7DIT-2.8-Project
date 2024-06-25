extends Node2D


func _enter_tree():
	get_tree().paused = true


func _on_menu_start():
	get_tree().paused = false
