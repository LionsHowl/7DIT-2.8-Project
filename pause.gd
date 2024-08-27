extends CanvasLayer


func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		if visible == true:
			visible = false
			get_tree().set_pause(false)
		elif get_parent().halt == "no":
			visible = true
			get_tree().set_pause(true)


func _on_back_button_pressed():
	visible = false
	get_tree().set_pause(false)
