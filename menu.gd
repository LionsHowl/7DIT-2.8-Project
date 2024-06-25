extends CanvasLayer

signal start
signal instructions
signal story


func  _ready():
	process_mode = PROCESS_MODE_WHEN_PAUSED


func _on_start_button_pressed():
	visible = false
	
	start.emit()


func _on_instuctions_imenu():
	visible = true


func _on_instructions_button_pressed():
	visible = false
	
	instructions.emit()


func _on_story_smenu():
	visible = true


func _on_story_button_pressed():
	visible = false
	
	story.emit()


func _on_game_over_menu():
	visible = true
