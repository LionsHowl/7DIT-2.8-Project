extends CharacterBody2D

signal banished

var player
var death
var slow
var stun
var status
var direction
var health = 0
var speed = 100


func _ready():
	player = get_node("/root/Game/Player")
	death = get_node("Death")
	slow = get_node("Slowness")
	stun = get_node("Stun")
	status = "Alive"


func _physics_process(_delta):
	direction = global_position.direction_to(player.global_position)
	
	if health > 0:
		velocity = direction * speed
		move_and_slide()


func dying():
	status = "Dead"
	
	get_node("Ghost").play_dying()
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


func _on_death_timeout():
	visible = false
	position = Vector2(1250, 625)


func _on_game_over_menu():
	visible = false


func _on_game_over_menu1():
	position = Vector2(115, 730)


func _on_game_over_menu2():
	position = Vector2(910, -100)


func _on_game_wave_3():
	health = 7
	visible = true
	
	get_node("Ghost").play_movement()

func _on_slowness_timeout():
	speed *= 2


func _on_stun_timeout():
	speed = 100
