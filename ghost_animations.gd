extends AnimatedSprite2D


func play_movement():
	#Plays the movement animation.
	play("Movement")


func play_dying():
	#Plays the death animation.
	play("Death")


func play_stun():
	#Plays the stun animation.
	play("Stun")


func _on_stun_timeout():
	#When the stun timer finishes then and if the mob is still alive then the
	#movement animation is played.
	if get_parent().status == "Alive":
		play("Movement")
