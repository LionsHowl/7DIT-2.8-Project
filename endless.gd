extends Node

signal summon(name)

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


func _ready() -> void:
	weak = preload("res://weak_ghost.tscn")
	mid = preload("res://mid_ghost.tscn")
	strong = preload("res://strong_ghost.tscn")


func spawn():
	type = rng.randi_range(1, 3)
	location = rng.randi_range(1, 4)
	
	if type == 1:
		mob = weak.instantiate()
		mob.health = 3
	elif type == 2:
		mob = mid.instantiate()
		mob.health = 5
	elif type == 3:
		mob = strong.instantiate()
		mob.health = 7
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
	mob.name = str(id)
	
	mob.visible = false
	add_child(mob)
	summon.emit(str(id))
	id += 1
	if type == 3:
		mob.collision_layer = (1 << 7) | (1 << 9)
		mob.collision_mask = (1 << 7) | (1 << 9)
	else:
		mob.collision_layer = (1 << 7) | (1 << 8)
		mob.collision_mask = (1 << 7) | (1 << 8)
	mob.scale = Vector2(0.192, 0.192)
	mob.global_position = Vector2(x, y)
	mob.visible = true


func _on_game_endless():
	for i in 10:
		spawn()
	get_node("Timer").start()


func _on_timer_timeout():
	spawn()


func _on_game_banish():
	spawn()
