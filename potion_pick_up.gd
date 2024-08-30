extends Area2D

var hp


func heal():
	#When when touching a health potion hp is set to the parent node's health
	#and if hp + 10 less than the health bar's max value then 10 is added to
	#hp. Otherwise hp is set to the health bar's max value. Then the parent
	#node's health is set to hp.
	hp = get_parent().health
	if hp + 10 < %"Health Bar".max_value:
		hp += 10
	else:
		hp = %"Health Bar".max_value
	get_parent().health = hp
