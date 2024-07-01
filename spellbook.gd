extends Area2D


func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE


func _process(_delta):
	look_at(get_global_mouse_position())
	rotation_degrees += 180


func shoot():
	const FIRE = preload("res://fire.tscn")
	var new_fire = FIRE.instantiate()
	var shooting_point = get_node("Shooting Point")
	
	new_fire.global_position = shooting_point.global_position
	new_fire.global_rotation = shooting_point.global_rotation
	
	add_child(new_fire)


func _on_timer_timeout():
	shoot()
