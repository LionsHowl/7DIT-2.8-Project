extends AnimatedSprite2D


func play_walk():
	play("Ghost_1")


func play_death():
	play("Ghost_1_death")


func play_stun():
	play("Stun")


func _on_stun_timeout():
	if get_parent().status == "Alive":
		play("Ghost_1")
