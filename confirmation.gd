extends ColorRect


func _on_yes_pressed():
	get_tree().quit()


func _on_no_pressed():
	visible = false
	if get_parent().name != "Quit Button":
		get_tree().paused = false


func _on_game_quit():
	visible = true
	get_tree().paused = true


func _on_quit_button_pressed():
	visible = true
