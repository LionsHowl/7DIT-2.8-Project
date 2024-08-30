extends Area2D

var direction
var travel_distance = 0


func _physics_process(delta):
	#Here the movement of the spell is programed.
	direction = Vector2.LEFT.rotated(rotation)
	position += direction * 750 * delta
	travel_distance += 750 * delta
	
	if travel_distance > 576:
		queue_free()


func _on_body_entered(body):
	#Activates take_earth_damage on the target to take damage from the earth
	#spell if the target has the function. Then the function deletes the earth
	#spell.
	if body.has_method("take_earth_damage"):
		body.take_earth_damage()
	queue_free()
