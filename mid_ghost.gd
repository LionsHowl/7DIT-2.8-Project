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
		velocity = direction * 100
		
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
