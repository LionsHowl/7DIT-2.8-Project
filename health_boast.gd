extends Area2D


func heal():
	#Add 5 to the parent mob's health when a health potiuon is picked up by it.
	get_parent().health += 5
