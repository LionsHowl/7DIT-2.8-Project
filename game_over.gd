extends CanvasLayer

signal menu
signal judge


func _on_menu_button_pressed():
	#When the menu button is pressed then the scene made no longer visible and
	#the menu signal is released.
	visible = false
	
	menu.emit()


func _on_player_over():
	#When the player dies then the judge signal is emitted so that the player's
	#socre/positon can be "judged" and then the scene becomes visible.
	judge.emit()
	visible = true
