extends Marker2D

func _process(_delta):
	#Here the spellbook follows the mouse postition around the pivot point.
	look_at(get_global_mouse_position())
	rotation_degrees += 180
