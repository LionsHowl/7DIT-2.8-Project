extends CharacterBody2D

signal banished

var player
var death
var slow
var stun
var direction
var health = 0
var speed = 75
var status = "Dead"


func _ready():
	player = get_node("/root/Game/Player")
	death = get_node("Death")
	slow = get_node("Slowness")
	stun = get_node("Stun")


func _physics_process(_delta):
	direction = global_position.direction_to(player.global_position)
	
	if health > 0:
		velocity = direction * speed
		move_and_slide()


func dying():
	status = "Dead"
	
	get_node("Ghost").play_death()
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
	
	if health <= 0 and status == "Alive":
		dying()
	elif status == "Alive":
		get_node("Ghost").play_stun()
		stun.start()


func take_air_damage():
	health -= 1
	
	if health == 0:
		dying()


func _on_timer_timeout():
	visible = false
	position = Vector2(1250, 625)


func reset():
	health = 3
	visible = true
	status = "Alive"
	
	get_node("Ghost").play_walk()


func _on_game_start():
	reset()

func _on_game_start1():
	position = Vector2(-20, 0)


func _on_game_start2():
	position = Vector2(35, -40)


func _on_game_start3():
	position = Vector2(-30, 75)


func _on_game_start4():
	position = Vector2(1165, -35)


func _on_game_start5():
	position = Vector2(1200, 680)


func _on_game_start6():
	position = Vector2(-45, 675)


func _on_game_over_menu():
	visible = false


func _on_game_over_menu7():
	position = Vector2(-55, -30)


func _on_game_over_menu8():
	position = Vector2(35, -40)


func _on_game_over_menu9():
	position = Vector2(-35, 85)


func _on_game_over_menu10():
	position = Vector2(1165, -35)


func _on_game_over_menu11():
	position = Vector2(1200, 680)


func _on_game_over_menu12():
	position = Vector2(-45, 675)


func _on_menu_start_extras():
	health = 0


func _on_game_wave_2():
	reset()


func _on_slowness_timeout():
	speed *= 2


func _on_stun_timeout():
	speed = 75
