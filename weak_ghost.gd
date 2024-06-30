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
		velocity = direction * 75
		
		get_node("Ghost").play_walk()
		move_and_slide()


func take_fire_damage():
	health -= 1
	if health == 0:
		get_node("Ghost").play_death()
		timer.start()
		banished.emit()


func _on_timer_timeout():
	visible = false
	position = Vector2(1250, 625)


func reset():
	health = 2
	visible = true


func _on_menu_start():
	position = Vector2(-20, 0)
	reset()


func _on_menu_start2():
	position = Vector2(35, -40)
	reset()


func _on_menu_start3():
	position = Vector2(-30, 75)
	reset()


func _on_menu_start4():
	position = Vector2(1165, -35)
	reset()


func _on_menu_start5():
	position = Vector2(1200, 680)
	reset()


func _on_menu_start6():
	position = Vector2(-45, 675)
	reset()


func _on_game_over_menu():
	visible = false


func _on_game_over_menu7():
	visible = false
	position = Vector2(-55, -30)


func _on_game_over_menu8():
	visible = false
	position = Vector2(35, -40)


func _on_game_over_menu9():
	visible = false
	position = Vector2(-30, 75)


func _on_game_over_menu10():
	visible = false
	position = Vector2(1165, -35)


func _on_game_over_menu11():
	visible = false
	position = Vector2(1200, 680)


func _on_game_over_menu12():
	visible = false
	position = Vector2(-45, 675)


func _on_menu_start_extras():
	health = 0


func _on_game_wave_2():
	reset()
