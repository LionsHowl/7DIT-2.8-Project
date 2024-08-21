extends Area2D


func _on_area_entered(area):
	if area.has_method("heal"):
		area.heal()
		queue_free()
