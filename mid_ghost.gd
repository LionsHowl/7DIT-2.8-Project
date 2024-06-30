extends CharacterBody2D

signal banished

var player
var health
var timer


func _ready():
	player = get_node("/root/Game/Player")
	timer = get_node("Timer")


func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	
	if health > 0:
		velocity = direction * 150
		
		get_node("Animations").play_movement()
		move_and_slide()


func take_fire_damage():
	health -= 1
	if health == 0:
		get_node("Animations").play_dying()
		timer.start()
		banished.emit()


func _on_timer_timeout():
	visible = false
	position = Vector2(1250, 625)


func reset():
	health = 2
	visible = true
