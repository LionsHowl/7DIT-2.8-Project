extends Area2D

var fire
var water
var earth
var air
var cast
var shooting_point
var timer
var spell = "Fire"


func _ready():
	fire = preload("res://fire.tscn")
	water = preload("res://water.tscn")
	earth = preload("res://earth.tscn")
	air = preload("res://air.tscn")
	timer = get_node("Timer")


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
	shooting_point = get_node("Pivot/Spellbook/Shooting Point")
	
	if spell == "Fire":
		cast = fire.instantiate()
	elif spell == "Water":
		cast = water.instantiate()
	elif spell == "Earth":
		cast = earth.instantiate()
	elif spell == "Air":
		cast = air.instantiate()
	cast.global_position = shooting_point.global_position
	cast.global_rotation = shooting_point.global_rotation
	add_child(cast)


func _on_timer_timeout():
	shoot()


func _on_player_fight():
	timer.start()


func _on_player_dead() -> void:
	timer.stop()
