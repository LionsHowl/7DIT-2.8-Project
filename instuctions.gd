extends CanvasLayer

signal imenu


func _on_menu_button_pressed():
	#When the menu button is pressed then all the instruction page are set to
	#not be visible except the menu page. Then the secne no longer is visible
	#and the signal imenu is emitted.
	visible = false
	%Main.visible = true
	%Fire.visible = false
	%Water.visible = false
	%Earth.visible = false
	%Air.visible = false
	%Score.visible = false
	
	imenu.emit()


func _on_menu_instructions():
	#When the signal instructions is recived from menu scene then the
	#instructions scen becomes visible.
	visible = true


func _on_main_fire_pressed():
	#When the next button on the main instructions page is pressed or the back
	#button on the fire instructions page is pressed then the main and fire
	#instruction pages become the oppersite visibility.
	%Main.visible = not %Main.visible
	%Fire.visible = not %Fire.visible


func _on_fire_water_pressed():
	#When the next button on the fire instructions page is pressed or the back
	#button on the water instructions page is pressed then the fire and water
	#instruction pages become the oppersite visibility.
	%Fire.visible = not %Fire.visible
	%Water.visible = not %Water.visible


func _on_water_earth_pressed():
	#When the next button on the water instructions page is pressed or the back
	#button on the earth instructions page is pressed then the water and earth
	#instruction pages become the oppersite visibility.
	%Water.visible = not %Water.visible
	%Earth.visible = not %Earth.visible


func _on_earth_air_pressed():
	#When the next button on the earth instructions page is pressed or the back
	#button on the air instructions page is pressed then the earth and air
	#instruction pages become the oppersite visibility.
	%Earth.visible = not %Earth.visible
	%Air.visible = not %Air.visible


func _on_air_score_pressed():
	#When the next button on the air instructions page is pressed or the back
	#button on the score instructions page is pressed then the air and score
	#instruction pages become the oppersite visibility.
	%Air.visible = not %Air.visible
	%Score.visible = not %Score.visible
