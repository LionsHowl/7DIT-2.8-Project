extends ColorRect


func _on_yes_pressed():
	#Quits the program when recives the signal that the Yes button has been
	#pressed.
	get_tree().quit()


func _on_no_pressed():
	#Stops the scene from being visable and unpauses the scene tree if the
	#instance is part the menu scene the program when recives the signal that
	#the No button has been pressed.
	visible = false
	if get_parent().name != "Quit Button":
		get_tree().paused = false


func _on_game_quit():
	#If Esc or CMD/Ctrl + Q is pressed then the scene becomes visible and the
	#scene tree is paused.
	visible = true
	get_tree().paused = true


func _on_quit_button_pressed():
	#If the quit button from the menu scene is pressed then the scene becomes
	#visible.
	visible = true
