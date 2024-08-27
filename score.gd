extends Label

var game
var wave


func _ready() -> void:
	game = get_node("/root/Game")



func _on_game_over_judge():
	wave = game.wave
	if wave == 1:
		text = "You made it to Wave One."
	elif wave == 2:
		text = "You made it to Wave Two."
	elif wave == 3:
		text = "You made it to Wave Three."
	else:
		text = "You scored " + str(game.mob_banished) + " points."
