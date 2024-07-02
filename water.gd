extends Area2D

var travel_distance = 0


func _physics_process(delta):
	var direction = Vector2.LEFT.rotated(rotation)
	position += direction * 750 * delta
	travel_distance += 750 * delta
	
	if travel_distance > 2500:
		queue_free()


func _on_body_entered(body):
	if body.has_method("take_water_damage"):
		body.take_water_damage()
	queue_free() 
