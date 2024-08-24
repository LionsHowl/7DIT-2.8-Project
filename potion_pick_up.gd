extends Area2D

var hp


func heal():
	hp = get_parent().health
	if hp + 10 < %"Health Bar".max_value:
		hp += 10
	else:
		hp = %"Health Bar".max_value
	get_parent().health = hp
