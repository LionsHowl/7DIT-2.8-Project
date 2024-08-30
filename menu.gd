extends CanvasLayer

signal start
signal instructions
signal story


func _on_start_button_pressed():
	#When the start button is pressed then the sence is set to be not visible
	#and the start signal is emitted.
	visible = false
	
	start.emit()


func _on_instuctions_imenu():
	#When the signal imenu from the instructions scene is recived, the menu
	#becomes visible.
	visible = true


func _on_instructions_button_pressed():
	#When the instructions button is pressed then the sence is set to not be
	#visible and the instructins signal is emitted.
	visible = false
	
	instructions.emit()


func _on_story_smenu():
	#When the signal smenu from the story scene is recived, the menu becomes
	#visible.
	visible = true


func _on_story_button_pressed():
	#When the story button is pressed then the sence is set to not be visible
	#and the story signal is emitted.
	visible = false
	
	story.emit()


func _on_game_over_menu():
	#When the menu signal is recived from the game_over scene, the menu becomes visible.
	visible = true
