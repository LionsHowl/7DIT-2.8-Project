extends Area2D

var potion
var prep = 0


func _on_clear():
	queue_free()


func _process(_delta):
	if prep == 0:
		potion = get_node("/root/Game/Respawn")
		potion.clear.connect(_on_clear)
		prep = 1


func _on_area_entered(area):
	if area.has_method("heal"):
		area.heal()
		queue_free()
