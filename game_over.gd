extends CanvasLayer

signal menu


func _on_menu_button_pressed():
	visible = false
	
	menu.emit()
