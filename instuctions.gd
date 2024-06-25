extends CanvasLayer

signal imenu


func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED


func _on_menu_button_pressed():
	visible = false
	
	imenu.emit()


func _on_menu_instructions():
	visible = true
