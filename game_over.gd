extends CanvasLayer

signal menu
signal judge


func _on_menu_button_pressed():
	visible = false
	
	menu.emit()


func _on_player_over():
	judge.emit()
	visible = true
