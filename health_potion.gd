extends Timer

signal clear

var x
var y
var spawn
var area
var rng = RandomNumberGenerator.new()


func _ready():
	area = preload("res://potion.tscn")	
	
	rng.randomize()


func _on_menu_start():
	start()


func _on_player_dead():
	stop()


func _on_timeout():
	spawn = area.instantiate()
	x = rng.randf_range(20, 1120)
	y = rng.randf_range(25, 615)
	spawn.visible = true
	add_child(spawn)
	spawn.global_position = Vector2(x, y)
	start()


func _on_game_over_menu():
	clear.emit()
