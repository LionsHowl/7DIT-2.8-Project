extends CanvasLayer


func _process(_delta):
	#If P, E, Shift or Space is pressed then if the pause menu is visible then
	#it no longer becomes visible and the scene tree is no longer paused.
	#Otherwise if halt from the main game node is no the scene becomes visible
	#and the scene tree gets paused.
	if Input.is_action_just_pressed("pause"):
		if visible == true:
			visible = false
			get_tree().set_pause(false)
		elif get_parent().halt == "no":
			visible = true
			get_tree().set_pause(true)


func _on_back_button_pressed():
	#When the back button is pressed the the pause menu is made not visible and
	#the scene tree gets un paused.
	visible = false
	get_tree().set_pause(false)
