extends CharacterBody2D

signal banished(type)

var player
var death
var slow
var stun
var status
var direction
var main
var free
var health = 0
var speed = 100
var prep = 0


func _ready():
	#Loads the nodes; Player, Death, Slowness, Stun and Game. Then the program
	#sets status to Alive and calls the play_movement fuction for the
	#animations	node.
	player = get_node("/root/Game/Player")
	death = get_node("Death")
	slow = get_node("Slowness")
	stun = get_node("Stun")
	status = "Alive"
	main = get_node("/root/Game")
	
	get_node("Animations").play_movement()


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
	#latter having the parameter mid.
	status = "Dead"
	
	get_node("Animations").play_dying()
	death.start()
	banished.emit("mid")


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
	#otherwise the animations node calls the play_stun function and the stun
	#timer starts.
	health -= 1
	speed = 0
	
	if health == 0:
		dying()
	else:
		get_node("Animations").play_stun()
		stun.start()


func take_air_damage():
	#When hit by the air spell the health variable gets decreaced by 1 and if
	#health is 0 the dying function is called.
	health -= 1
	
	if health <= 0:
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
	#Reset sets the health to 5 and makes the mob visible as well as them
	#playing the play_movement function in animations.
	health = 5
	visible = true
	
	get_node("Animations").play_movement()


func _on_game_over_menu():
	#When the menu button is pressed in the game over scene all the mid mobs
	#are set to be no longer visible.
	visible = false


#The next 4 functions are for when the menu button is pressed in the game over
#scene, the mid mobs from wave 2 head back to their positions for the next wave
#2.
func _on_game_over_menu1():
	position = Vector2(-20, 25)


func _on_game_over_menu2():
	position = Vector2(1180, 100)


func _on_game_over_menu3():
	position = Vector2(1135, 700)


func _on_game_over_menu4():
	position = Vector2(25, 685)


func _on_game_wave_2():
	#When wave 2 starts, the reset function is called which makes the mid mobs
	#wave 2 move.
	reset()


func _on_menu_start():
	#When the start button in the menu scene is pressed then health is set to
	#0.
	health = 0


func _on_slowness_timeout():
	#When the slowness timer finishes then the mobs speed is returned to
	#normal.
	speed *= 2


func _on_stun_timeout():
	#When the stun timer finishes then the mobs speed is returned to normal.
	speed = 100


func _on_game_wave_3():
	#When wave 3 starts, the reset function is called which makes the weak mobs
	#wave 3 move.
	reset()


#The next 4 functions are for when the menu button is pressed in the game over
#scene, the mid mobs from wave 3 head back to their positions for the next wave
#3.
func _on_game_over_menu5():
	position = Vector2(-60, 115)


func _on_game_over_menu6():
	position = Vector2(2100, 210)


func _on_game_over_menu7():
	position = Vector2(910, 730)


func _on_game_over_menu8():
	position = Vector2(-50, 665)


func _on_clear():
	#Deletes the mobs spawned for the endless wave.
	queue_free()
