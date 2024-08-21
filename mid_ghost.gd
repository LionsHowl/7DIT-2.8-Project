extends CharacterBody2D

signal banished

var player
var health
var death
var slow
var stun
var status
var direction
var speed = 100


func _ready():
	player = get_node("/root/Game/Player")
	death = get_node("Death")
	slow = get_node("Slowness")
	stun = get_node("Stun")
	status = "Alive"
	get_node("Animations").play_movement()


func _physics_process(_delta):
	direction = global_position.direction_to(player.global_position)
	
	if health > 0:
		velocity = direction * speed
		move_and_slide()


func dying():
	status = "Dead"
	
	get_node("Animations").play_dying()
	death.start()
	banished.emit()
	



func take_fire_damage():
	health -= 2
	
	if health == 0 or health == -1:
		dying()


func take_water_damage():
	health -= 1
	speed /= 2
	
	if health == 0:
		dying()
	else:
		slow.start()


func take_earth_damage():
	health -= 1
	speed = 0
	
	if health == 0:
		dying()
	else:
		get_node("Animations").play_stun()
		stun.start()


func take_air_damage():
	health -= 1
	
	if health <= 0:
		dying()


func _on_timer_timeout():
	visible = false
	position = Vector2(1250, 625)


func reset():
	health = 5
	visible = true


func _on_game_over_menu():
	visible = false


func _on_game_over_menu1():
	position = Vector2(-20, 25)


func _on_game_over_menu2():
	position = Vector2(1180, 100)


func _on_game_over_menu3():
	position = Vector2(1135, 700)


func _on_game_over_menu4():
	position = Vector2(25, 685)


func _on_game_wave_2():
	reset()


func _on_menu_start():
	health = 0


func _on_slowness_timeout():
	speed *= 2


func _on_stun_timeout():
	speed = 100
