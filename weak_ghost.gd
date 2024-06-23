extends CharacterBody2D

var player
var health = 2
var timer

func _ready():
	player = get_node("/root/Game/Player")
	timer = get_node("Timer")


func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	
	velocity = direction * 75
	
	if health <= 0:
		velocity = direction * 0
	move_and_slide()


func take_fire_damage():
	health -= 1
	if health == 0:
		get_node("Ghost").play_death()
		timer.start()


func _on_timer_timeout():
	queue_free()
