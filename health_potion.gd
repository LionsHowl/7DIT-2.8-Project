extends Timer

signal clear

var x
var y
var spawn
var area
var rng = RandomNumberGenerator.new()


func _ready():
	#Preloads the the potion scene and sets the random number generator to
	#randimize.
	area = preload("res://potion.tscn")	
	
	rng.randomize()


func _on_menu_start():
	#When the start signal from the menu scene is recived then the timer will
	#start.
	start()


func _on_player_dead():
	#When the dead signal from the player scene is recived then the timer will
	#stop.
	stop()


func _on_timeout():
	#When the timer finishes then spaen is set to the instantiated potion and
	#the location of spawn dieremenid by the random number generator. Then the
	#potion is made visible and added as a child. The timer then starts again.
	spawn = area.instantiate()
	x = rng.randf_range(20, 1120)
	y = rng.randf_range(25, 615)
	spawn.visible = true
	add_child(spawn)
	spawn.global_position = Vector2(x, y)
	start()


func _on_game_over_menu():
	#When the game is over and the player has left the game over screen then
	#the signal clear is sent to delete the potions that are the children of
	#Respawn.
	clear.emit()
