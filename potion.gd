extends Area2D

var potion
var prep = 0


func _on_clear():
	#When recivining the signal clear, the potions get deleted.
	queue_free()


func _process(_delta):
	#Only done once: The program connects to the clear signal from respawn.
	if prep == 0:
		potion = get_node("/root/Game/Respawn")
		potion.clear.connect(_on_clear)
		prep = 1


func _on_area_entered(area):
	#When the potion overlaps with another area2d node then if it has the
	#method heal it calls heal and deletes itself.
	if area.has_method("heal"):
		area.heal()
		queue_free()
