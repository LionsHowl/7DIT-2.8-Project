extends Area2D

var direction
var travel_distance = 0


func _physics_process(delta):
	#Here the movement of the spell is programed.
	direction = Vector2.LEFT.rotated(rotation)
	position += direction * 750 * delta
	travel_distance += 750 * delta
	
	#Travels twice the distance compared to the other spells
	if travel_distance > 1152:
		queue_free()


func _on_body_entered(body):
	#Activates take_air_damage on the target to take damage from the air spell 
	#if the target has the function. Then the function deletes the air spell.
	if body.has_method("take_air_damage"):
		body.take_air_damage()
	queue_free()
