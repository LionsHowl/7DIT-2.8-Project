extends CharacterBody2D

var health = 100


func _physics_process(delta):
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	var overlaping_weak_mobs = %"Hurt Box/Weak".get_overlapping_bodies()
	
	velocity = direction * 150
	
	if health <= 0:
		velocity = direction * 0
	move_and_slide()
	if velocity.length() > 0:
		get_node("Animated Body").play_Walking_animation()
	else:
		get_node("Animated Body").play_Idle_animation()
	
	if overlaping_weak_mobs.size() > 0:
		health -= 5 * overlaping_weak_mobs.size() * delta
	%"Health Bar".value = health
