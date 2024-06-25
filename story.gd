extends CanvasLayer

signal smenu


func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED


func _on_menu_button_pressed():
	visible = false
	
	smenu.emit()


func _on_menu_story():
	visible = true
