extends CanvasLayer

signal start


func  _ready():
	process_mode = PROCESS_MODE_WHEN_PAUSED


func _on_start_button_pressed():
	visible = false
	
	start.emit()
