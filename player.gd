extends CharacterBody2D

signal dead
signal fight
signal over

var health
var timer
var facing
var stylebox_flat
var overlaping_weaker_mobs
var direction
var overlaping_strong_mobs
var status = "Paused"


func _ready():
	#Sets the process mode to pausable and creates a new StyleBoxFlat style.
	process_mode = Node.PROCESS_MODE_PAUSABLE
	stylebox_flat = StyleBoxFlat.new()
	stylebox_flat.corner_radius_top_left = 5
	stylebox_flat.corner_radius_top_right = 5
	stylebox_flat.corner_radius_bottom_left = 5
	stylebox_flat.corner_radius_bottom_right = 5


func _physics_process(delta):
	#If status is alive then the following things happen.
	if status == "Alive":
		#Here the direction is set of the player by using the input map and the
		#overlaping_weaker_mobs and overlaping_strong_mobs is set the amount of
		#boides overlapping the respective area2d nodes.
		direction = Input.get_vector("move_left","move_right","move_up","move_down")
		overlaping_weaker_mobs = %"Hurt Box/Weak_Mid".get_overlapping_bodies()
		overlaping_strong_mobs = %"Hurt Box/Strong".get_overlapping_bodies()
		#Here the velocity of the player is set.
		velocity = direction * 150
		
		if health > 0:
			#If health is greater than 0 and the player is moving left then
			#facing is left otherwise if the player is moving right facing
			#equals right. Then the Player moves.
			if Input.is_action_pressed("move_left"):
				facing = "Left"
			elif Input.is_action_pressed("move_right"):
				facing = "Right"
			move_and_slide()
			#As long as the length of velocity is greater than 0 then the
			#walking animation is played but dthe direction of the player is
			#determined by facing. Otherise the idle animation is played and
			#again the driection of the player is determined by the variable
			#facing.
			if velocity.length() > 0:
				if facing == "Right":
					%"Animated Body".play_walking()
				else:
					%"Animated Body".play_walkingl()
			else:
				if facing == "Right":
					%"Animated Body".play_idle()
				else:
					%"Animated Body".play_idlel()
		#For every item in the array overlaping_weaker_mobs health is removed
		#by 5 times delta(-5 per second) and for every item in the array
		#overlaping_strong_mobs health is removed by 10 times 
		#delta(-10 per second). Then the value of the health bar is set to
		#health.
		if overlaping_weaker_mobs.size() > 0:
			health -= 5 * overlaping_weaker_mobs.size() * delta
		elif overlaping_strong_mobs.size() > 0:
			health -= 10 * overlaping_strong_mobs.size() * delta
		%"Health Bar".value = health
		#If health is les than or equal to 0 then the dead signal is emited and
		#status is set to dead.
		if health <= 0:
			dead.emit()
			status = "dead"
		#If health is les than or equal to 25 then the colour of the health bar
		#is set to red otherwise it is green.
		if health <= 25:
			stylebox_flat.bg_color = Color(255, 0, 0)
		else:
			stylebox_flat.bg_color = Color("#43ff00")
		%"Health Bar".add_theme_stylebox_override("fill", stylebox_flat)


func _on_dead():
	#When the dead signal is recived the prcceing mode for the player is set to
	#always. Then the health bar and spellbook iare set to not be be visible.
	#Then the scene tree gets paused and deppending on facing for direction the
	#dying snimation is played and the death timer starts.
	process_mode = Node.PROCESS_MODE_ALWAYS
	timer = get_node("Death")
	%"Health Bar".visible = false
	get_node("Spellbook").visible = false
	get_tree().paused = true
	
	if facing == "Right":
		%"Animated Body".play_dying()
	else:
		%"Animated Body".play_dyingl()
	timer.start()


func _on_timer_timeout():
	process_mode = Node.PROCESS_MODE_PAUSABLE
	over.emit()


func _on_game_start():
	#When the start button is pressed fom the menu scene the player si sent to
	#560, 245 and made visible. The player's health is set to 100 and the
	#health bar and spellbook are also made visible. Then the fight signal is
	#emitted.
	status = "Alive"
	position = Vector2(560, 245)
	visible = true
	health = 100
	get_node("Spellbook").visible = true
	%"Health Bar".visible = true
	
	fight.emit()


func _on_game_over_menu():
	#When the menu button is pressed on the game over scene the player is set
	#to not be visible and is sent to 560, 245.
	visible = false
	position = Vector2(560, 245)
