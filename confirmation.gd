extends ColorRect


func _on_yes_pressed():
	get_tree().quit()


func _on_no_pressed():
	get_tree().paused = false
	visible = false


func _on_menu_quit_2():
	visible = true
	get_tree().paused = true


func _on_game_quit():
	print(3)
	visible = true
	get_tree().paused = true
	print(4)
