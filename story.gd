extends CanvasLayer

signal smenu


func _on_menu_button_pressed():
	visible = false
	
	smenu.emit()


func _on_menu_story():
	visible = true
