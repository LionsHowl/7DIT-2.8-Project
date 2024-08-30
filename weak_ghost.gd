extends CharacterBody2D

signal banished(type)

var player
var death
var slow
var stun
var direction
var main
var free
var health = 0
var speed = 75
var status = "Dead"
var prep = 0


func _ready():
	#Loads the nodes; Player, Death, Slowness, Stun and Game. Then the program
	#sets status to Alive.
	player = get_node("/root/Game/Player")
	death = get_node("Death")
	slow = get_node("Slowness")
	stun = get_node("Stun")
	main = get_node("/root/Game")


func _physics_process(_delta):
	#Every frame the direction get updated so that the mob follows the player.
	direction = global_position.direction_to(player.global_position)
	
	#Here tells the mob to move as long as it isn't banished.
	if health > 0:
		velocity = direction * speed
		move_and_slide()
	#Only to happen once, if the parent node is Endless then the program
	#connects to the signal clear for when the player dies and presses the menu
	#button.
	if prep == 0:
		if get_parent().name == "Endless":
			free = get_node("/root/Game/Endless")
			free.clear.connect(_on_clear)
			prep = 1


func dying():
	#Here the status gets updated to dead and the animation node calls the
	#play_dying function. The signals death and banished are emitted with the
	#latter having the parameter weak.
	status = "Dead"
	
	get_node("Ghost").play_dying()
	death.start()
	banished.emit("weak")


func take_fire_damage():
	#When hit by the fire spell the health variable gets decreaced by 2 and if
	#health is 0 or -1 the dying function is called.
	health -= 2
	
	if health == 0 or health == -1:
		dying()


func take_water_damage():
	#When hit by the water spell the health variable gets decreaced by 1 and
	#the mob's speed is halved. If health is 0 the dying function is called
	#otherwise the slow timer starts.
	health -= 1
	speed /= 2
	
	if health == 0:
		dying()
	else:
		slow.start()


func take_earth_damage():
	#When hit by the earth spell the health variable gets decreaced by 1 and
	#the mob's speed is set to 0. If health is 0 the dying function is called
	#otherwise the ghost node calls the play_stun function and the stun timer
	#starts.
	health -= 1
	speed = 0
	
	if health <= 0 and status == "Alive":
		dying()
	elif status == "Alive":
		get_node("Ghost").play_stun()
		stun.start()


func take_air_damage():
	#When hit by the air spell the health variable gets decreaced by 1 and if
	#health is 0 the dying function is called.
	health -= 1
	
	if health == 0:
		dying()


func _on_timer_timeout():
	#When the timer finishes when the death animation finishes the mob is to
	#not be visible and praghout to the coradiats 1250, 625 but if the the
	#variable wave from the game node is 4 then the mob gets deleted.
	visible = false
	position = Vector2(1250, 625)
	if main.wave == 4:
		queue_free()


func reset():
	#Reset sets the health to 3 and makes the mob visible as well as them
	#playing the play_movement function in ghost.
	health = 3
	visible = true
	status = "Alive"
	
	get_node("Ghost").play_movement()


func _on_game_start():
	#When the start signal is recived from the main game node then the function
	#reset is called.
	reset()


#The next 6 functions say that when the start signal is recived from the main
#game node that the mobs should go to thier relative places to start wave 1.
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
	#When the menu button is pressed in the game over scene all the weak mobs
	#are set to be no longer visible.
	visible = false


#The next 6 functions are for when the menu button is pressed in the game over
#scene, the weak mobs from wave 2 head back to their positions for the next
#wave 2.
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
	#When the start signal is recived from the menu scene all the weak mobs
	#that aren't in wave 1 health is set to 0.
	health = 0


func _on_game_wave_2():
	#When wave 2 starts, the reset function is called which makes the weak mobs
	#wave 2 move.
	reset()


func _on_slowness_timeout():
	#When the slowness timer finishes then the mobs speed is returned to
	#normal.
	speed *= 2


func _on_stun_timeout():
	#When the stun timer finishes then the mobs speed is returned to normal.
	speed = 75


func _on_game_wave_3():
	#When wave 3 starts, the reset function is called which makes the weak mobs
	#wave 3 move.
	reset()


#The next 4 functions are for when the menu button is pressed in the game over
#scene, the weak mobs from wave 3 head back to their positions for the next
#wave 3.
func _on_game_over_menu13():
	position = Vector2(175, -50)


func _on_game_over_menu14():
	position = Vector2(-76, 490)


func _on_game_over_menu15():
	position = Vector2(1215, 505)


func _on_game_over_menu16():
	position = Vector2(1165, -35)


func _on_clear():
	#Deletes the mobs spawned for the endless wave.
	queue_free()
