extends Label

var game
var wave


func _ready():
	#game is set to the main game node.
	game = get_node("/root/Game")



func _on_game_over_judge():
	#wave is set to the main game node's varible wave. And if wave is 1, 2, or
	#3 then text is set to saying the end user made it to repective wave. But
	#if wave is 4 then text is set to You scored x points. where x is the
	#varible mob_banished from the main game node.
	wave = game.wave
	if wave == 1:
		text = "You made it to Wave One."
	elif wave == 2:
		text = "You made it to Wave Two."
	elif wave == 3:
		text = "You made it to Wave Three."
	else:
		text = "You scored " + str(game.mob_banished) + " points."
