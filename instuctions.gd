extends CanvasLayer

signal imenu


func _on_menu_button_pressed():
	visible = false
	%Main.visible = true
	%Fire.visible = false
	%Water.visible = false
	%Earth.visible = false
	%Air.visible = false
	%Score.visible = false
	
	imenu.emit()


func _on_menu_instructions():
	visible = true


func _on_main_fire_pressed():
	%Main.visible = not %Main.visible
	%Fire.visible = not %Fire.visible


func _on_fire_water_pressed():
	%Fire.visible = not %Fire.visible
	%Water.visible = not %Water.visible


func _on_water_earth_pressed():
	%Water.visible = not %Water.visible
	%Earth.visible = not %Earth.visible


func _on_earth_air_pressed():
	%Earth.visible = not %Earth.visible
	%Air.visible = not %Air.visible


func _on_air_score_pressed():
	%Air.visible = not %Air.visible
	%Score.visible = not %Score.visible
