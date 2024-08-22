extends AnimatedSprite2D


func play_movement():
	play("Movement")


func play_dying():
	play("Death")


func play_stun():
	play("Stun")


func _on_stun_timeout():
	if get_parent().status == "Alive":
		play("Movement")
