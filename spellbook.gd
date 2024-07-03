extends Area2D

var spell = "Fire"
var fire
var water
var earth
var air


func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE
	fire = preload("res://fire.tscn")
	water = preload("res://water.tscn")
	earth = preload("res://earth.tscn")
	air = preload("res://air.tscn")


func _process(_delta):
	if Input.is_action_just_pressed("fire"):
		spell = "Fire"
	elif Input.is_action_just_pressed("water"):
		spell = "Water"
	elif  Input.is_action_just_pressed("earth"):
		spell = "Earth"
	elif Input.is_action_just_pressed("air"):
		spell = "Air"


func shoot():
	var shooting_point = get_node("Pivot/Spellbook/Shooting Point")
	var cast
	
	if spell == "Fire":
		cast = fire.instantiate()
	elif spell == "Water":
		cast = water.instantiate()
	elif spell == "Earth":
		cast = earth.instantiate()
		#print("a", cast.global_position)
	elif spell == "Air":
		cast = air.instantiate()
	cast.global_position = shooting_point.global_position
	cast.global_rotation = shooting_point.global_rotation
	add_child(cast)


func _on_timer_timeout():
	shoot()
