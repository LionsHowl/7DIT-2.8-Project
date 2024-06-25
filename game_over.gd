extends CanvasLayer

signal menu


func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED


func _on_menu_button_pressed():
	visible = false
	
	menu.emit()
