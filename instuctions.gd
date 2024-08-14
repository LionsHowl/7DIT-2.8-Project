extends CanvasLayer

signal imenu


func _on_menu_button_pressed():
	visible = false
	
	imenu.emit()


func _on_menu_instructions():
	visible = true
