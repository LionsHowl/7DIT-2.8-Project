extends ColorRect


func _on_quit_button_pressed():
	visible = true


func _on_no_pressed():
	visible = false


func _on_yes_pressed():
	get_tree().quit()
