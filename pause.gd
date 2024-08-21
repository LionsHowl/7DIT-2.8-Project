extends CanvasLayer


func _process(delta):
	if Input.is_action_just_pressed("pause"):
		if visible == true:
			visible = false
			get_parent().menu = "yes"
			get_tree().set_pause(false)
		else:
			visible = true
			get_tree().set_pause(true)
			get_parent().menu = "no"


func _on_back_button_pressed():
	visible = false
	get_tree().set_pause(false)
	get_parent().menu = "no"
