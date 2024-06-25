extends CharacterBody2D

signal dead

var status = "Paused"
var health
var end
var timer


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	end = get_node("/root/Game/Game Over")


func _physics_process(delta):
	if status == "Alive":
		var direction = Input.get_vector("move_left","move_right","move_up","move_down")
		var overlaping_weak_mobs = %"Hurt Box/Weak".get_overlapping_bodies()
		
		velocity = direction * 150
		
		if health > 0:
			move_and_slide()
			if velocity.length() > 0:
				%"Animated Body".play_walking()
			else:
				%"Animated Body".play_idle()
		
		if overlaping_weak_mobs.size() > 0:
			health -= 5 * overlaping_weak_mobs.size() * delta
		%"Health Bar".value = health
		if health <= 0:
			dead.emit()
			status = "dead"


func _on_dead():
	timer = get_node("Timer")
	
	%"Health Bar".visible = false
	get_node("Spellbook").visible = false
	get_tree().paused = true
	%"Animated Body".play_dying()
	timer.start()


func _on_timer_timeout():
	end.visible = true


func _on_menu_start():
	status = "Alive"
	position = Vector2(560, 245)
	visible = true
	health = 100
	
	get_node("Spellbook").visible = true
	%"Health Bar".visible = true


func _on_game_over_menu():
	visible = false
