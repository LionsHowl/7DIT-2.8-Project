extends AnimatedSprite2D


func play_idle():
	#Plays the idle animation for when the player is facing the right.
	play("Idle")


func play_walking():
	#Plays the walking animation for when the player is going right.
	play("Walking")


func play_dying():
	#Plays the dying animation for when the player dies facing the right.
	play("Dying")


func play_walkingl():
	#Plays the walking animation for when the player is going left.
	play("Walking Left")


func play_dyingl():
	#Plays the dying animation for when the player dies facing the left.
	play("Dying Left")


func play_idlel():
	#Plays the idle animation for when the player is facing the left.
	play("Idle Left")
