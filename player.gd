extends CharacterBody2D


func _physics_process(_delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	
	velocity = direction * 150
	
	move_and_slide()
	if velocity.length() > 0:
		get_node("Animated Body").play_Walking_animation()
	else:
		get_node("Animated Body").play_Idle_animation()
