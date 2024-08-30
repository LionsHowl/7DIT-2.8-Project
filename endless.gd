extends Node

signal summon
signal clear

var weak
var mid
var strong
var type
var mob
var location
var x
var y
var rng = RandomNumberGenerator.new()
var id = 1


func _ready():
	#Preloads the different mobs.
	weak = preload("res://weak_ghost.tscn")
	mid = preload("res://mid_ghost.tscn")
	strong = preload("res://strong_ghost.tscn")


func emit_summon_signal():
	#Sends the signal summon to main game node to connect the signal banished
	#newly spawned mobs to the main game node. 
	summon.emit()


func spawn():
	#Spawns a random mob.
	#First a random number generator determines which mob gets spwned.
	type = rng.randi_range(1, 3)
	#Secondly a random number generator determines which side of the screen the
	#mob will spawn.
	location = rng.randi_range(1, 4)
	
	#Grabs the right mob to instantiate and sets their health accordingly.
	if type == 1:
		mob = weak.instantiate()
		mob.health = 3
	elif type == 2:
		mob = mid.instantiate()
		mob.health = 5
	elif type == 3:
		mob = strong.instantiate()
		mob.health = 7
	#A random number generator deternines either an x or y value for where the
	#mob spawns.
	if location == 1:
		x = rng.randi_range(-100, 1250)
		y = -50
	elif location == 2:
		x = 1210
		y = rng.randi_range(-50, 700)
	elif location == 3:
		y = 700
		x = rng.randi_range(-100, 1250)
	elif location == 4:
		x = -25
		y = rng.randi_range(-50, 700)
	#Sets the name of the mobs to a number to create an unique name so that
	#they can be called on to connect the instance to the main game scene for
	#the signal banished.
	mob.name = str(id)
	id += 1
	#Sets the mobs to not be visible then in the next frame adds the instance
	#as a child and calls the functions emit_summon_signal to sends the signal
	#summon to main game node so that the instance connects the signal banished
	#to the main game node. 
	mob.visible = false
	call_deferred("add_child", mob)
	call_deferred("emit_summon_signal")
	#On the next frame the physics layers and masks get set so that the mobs
	#can be shot and the players scores gets updated.
	if type == 3:
		mob.call_deferred("set_collision_layer", (1 << 7) | (1 << 9))
		mob.call_deferred("set_collision_mask", (1 << 7) | (1 << 9))
	else:
		mob.call_deferred("set_collision_layer", (1 << 7) | (1 << 8))
		mob.call_deferred("set_collision_mask", (1 << 7) | (1 << 8))
	#Here the mobs szie a position are set beroe making it visible.
	mob.call_deferred("set_scale", Vector2(0.192, 0.192))
	mob.call_deferred("set_global_position", Vector2(x, y))
	mob.call_deferred("set_visible", true)


func _on_game_endless():
	#When the enless wave starts the spawn function gets called 10 times to
	#start the wave. Then the timer starts to add more mobs.
	for i in 10:
		spawn()
	get_node("Timer").start()


func _on_timer_timeout():
	#To increace the dificulty every minitue the max amount of ghosts
	#increaces. Here when the signal that the timer is finished is recived the
	#spawn function is called.
	spawn()


func _on_game_banish():
	#When a mob dies in the endless wave the main game node sends the signal
	#banish which calls the spawn function making the wave endless.
	spawn()


func _on_game_over_menu():
	#When the game is over and the player has left the game over screen then
	#the signal clear is sent to delete the mobs that are the children of
	#Endless.
	clear.emit()
