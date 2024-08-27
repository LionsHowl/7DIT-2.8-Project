extends CharacterBody2D

signal dead
signal fight

var health
var end
var timer
var facing
var stylebox_flat
var overlaping_weaker_mobs
var direction
var overlaping_strong_mobs
var status = "Paused"


func _ready():
	process_mode = Node.PROCESS_MODE_PAUSABLE
	end = get_node("/root/Game/Game Over")
	stylebox_flat = StyleBoxFlat.new()
	stylebox_flat.corner_radius_top_left = 5
	stylebox_flat.corner_radius_top_right = 5
	stylebox_flat.corner_radius_bottom_left = 5
	stylebox_flat.corner_radius_bottom_right = 5


func _physics_process(delta):
	if status == "Alive":
		direction = Input.get_vector("move_left","move_right","move_up","move_down")
		overlaping_weaker_mobs = %"Hurt Box/Weak_Mid".get_overlapping_bodies()
		overlaping_strong_mobs = %"Hurt Box/Strong".get_overlapping_bodies()
		
		velocity = direction * 150
		
		if health > 0:
			if Input.is_action_pressed("move_left"):
				facing = "Left"
			elif Input.is_action_pressed("move_right"):
				facing = "Right"
			move_and_slide()
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
		
		if overlaping_weaker_mobs.size() > 0:
			health -= 5 * overlaping_weaker_mobs.size() * delta
		elif overlaping_strong_mobs.size() > 0:
			health -= 10 * overlaping_strong_mobs.size() * delta
		%"Health Bar".value = health
		if health <= 0:
			dead.emit()
			status = "dead"
		
		if health <= 25:
			stylebox_flat.bg_color = Color(255, 0, 0)
		else:
			stylebox_flat.bg_color = Color("#43ff00")
		%"Health Bar".add_theme_stylebox_override("fill", stylebox_flat)


func _on_dead():
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
	end.visible = true
	process_mode = Node.PROCESS_MODE_PAUSABLE


func _on_game_start():
	status = "Alive"
	position = Vector2(560, 245)
	visible = true
	health = 100
	get_node("Spellbook").visible = true
	%"Health Bar".visible = true
	
	fight.emit()


func _on_game_over_menu():
	visible = false
	position = Vector2(560, 245)
