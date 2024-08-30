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
	#Preloads the fire, water, earth and air scenes and gets the timer node.
	fire = preload("res://fire.tscn")
	water = preload("res://water.tscn")
	earth = preload("res://earth.tscn")
	air = preload("res://air.tscn")
	timer = get_node("Timer")


func _process(_delta):
	#If an input action was processed then the varible spell is set to the
	#corresponding element.
	if Input.is_action_just_pressed("fire"):
		spell = "Fire"
	elif Input.is_action_just_pressed("water"):
		spell = "Water"
	elif Input.is_action_just_pressed("earth"):
		spell = "Earth"
	elif Input.is_action_just_pressed("air"):
		spell = "Air"


func shoot():
	#shooting_point is set to the node Shooting Point and depinding on the
	#varible spell, the corrisponding scene is instantiated. The spells
	#potition and rotation is set to the Shooting Point. Then the instance is
	#made a child of the spellbook.
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
	#When the timer finishes the spell/mana reloads and the spell books shootss
	#again by calling the function shoot.
	shoot()


func _on_player_fight():
	#Starts the timer when reciving the signal fight from the player scene.
	timer.start()


func _on_player_dead():
	#Stops the timer when reciving the signal dead from the player scene.
	timer.stop()
