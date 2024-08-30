extends CanvasLayer

signal smenu


func _on_menu_button_pressed():
	#When the menu button is pressed then the scene is no longer visible then
	#the signal smenu is emitted.
	visible = false
	
	smenu.emit()


func _on_menu_story():
	#When the signal story is recived from the menu scene the scene becomes
	#visible.
	visible = true
