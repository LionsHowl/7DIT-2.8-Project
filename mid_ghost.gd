extends CharacterBody2D

signal banished

var speed = 100
var player
var health
var death
var slow


func _ready():
	player = get_node("/root/Game/Player")
	death = get_node("Death")


func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	
	if health > 0:
		velocity = direction * speed
		
		get_node("Animations").play_movement()
		move_and_slide()


func take_fire_damage():
	health -= 1
	
	if health <= 0:
		get_node("Animations").play_dying()
		death.start()
		banished.emit()


func take_water_damage():
	health -= 1
	speed /= 2
	
	if health <= 0:
		get_node("Animations").play_dying()
		death.start()
		banished.emit()
	else:
		slow.start()


func _on_timer_timeout():
	visible = false
	position = Vector2(1250, 625)


func reset():
	health = 3
	visible = true


func _on_game_over_menu():
	visible = false
	position = Vector2(-20, 25)


func _on_game_over_menu2():
	visible = false
	position = Vector2(1180, 100)


func _on_game_over_menu3():
	visible = false
	position = Vector2(1135, 700)


func _on_game_over_menu4():
	visible = false
	position = Vector2(25, 685)


func _on_game_wave_2():
	reset()


func _on_menu_start():
	health = 0


func _on_slowness_timeout():
	speed *= 2
