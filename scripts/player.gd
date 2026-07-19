extends CharacterBody2D

var slime_attack_range: bool = false
var slime_attack_cooldown: bool = true
var player_hp: int = 100
var player_alive: bool = true

var attack_ip: bool = false

const speed = 70
var current_direction: String = "none"

func player() -> void:
	return

func _ready() -> void:
	$AnimatedSprite2D.play("front_idle")
	return

func _physics_process(delta: float) -> void:
	player_movement(delta)
	current_camera()
	slime_attack()
	update_hp()
	attack()
	return

func player_movement(delta: float) -> void:
	
	if Input.is_action_pressed("ui_right"):
		current_direction = "right"
		play_animation(true)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_direction = "left"
		play_animation(true)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_up"):
		current_direction = "up"
		play_animation(true)
		velocity.x = 0
		velocity.y = -speed
	elif Input.is_action_pressed("ui_down"):
		current_direction = "down"
		play_animation(true)
		velocity.x = 0
		velocity.y = speed
	else:
		play_animation(false)
		velocity.x = 0
		velocity.y = 0

	move_and_slide()
	return

func play_animation(movement: bool) -> void:
	var direction = current_direction
	var animation = $AnimatedSprite2D
	
	if direction == "right":
		animation.flip_h = false
		if movement:
			animation.play("side_walk")
		else:
			# Check if attack animation is ongoing
			if not attack_ip:
				animation.play("side_idle")
	
	if direction == "left":
		animation.flip_h = true
		if movement:
			animation.play("side_walk")
		else:
			if not attack_ip:
				animation.play("side_idle")
	
	if direction == "up":
		animation.flip_h = false
		if movement:
			animation.play("back_walk")
		else:
			if not attack_ip:
				animation.play("back_idle")
	
	if direction == "down":
		animation.flip_h = false
		if movement:
			animation.play("front_walk")
		else:
			if not attack_ip:
				animation.play("front_idle")
	return

func current_camera() -> void:
	if global.current_scene == "world":
		$Camera_world.enabled = true
		$Camera_camp.enabled = false
	elif global.current_scene == "camp":
		$Camera_world.enabled = false
		$Camera_camp.enabled = true
	return

func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("slime"):
		slime_attack_range = true
	return

func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("slime"):
		slime_attack_range = false
	return

func slime_attack() -> void:
	if slime_attack_range and slime_attack_cooldown:
		player_hp -= 10
		slime_attack_cooldown = false
		$attack_cooldown.start()
	return

func update_hp() -> void:
	var hp_bar = $hp_bar
	hp_bar.value = player_hp
	
	if player_hp >= 100:
		hp_bar.visible = false
	else:
		hp_bar.visible = true
	return

func _on_attack_cooldown_timeout() -> void:
	$attack_cooldown.stop()
	slime_attack_cooldown = true
	return

func attack() -> void:
	var direction: String = current_direction
	if Input.is_action_just_pressed("attack"):
		global.player_current_attack = true
		attack_ip = true
		
		if direction == "right":
			# Attack timer = Frames / FPS
			$attack_timer.start()
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("side_attack")
			pass
		elif direction == "left":
			$attack_timer.start()
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("side_attack")
			pass
		elif direction == "up":
			$attack_timer.start()
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("back_attack")
			pass
		elif direction == "down":
			$attack_timer.start()
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("front_attack")
			pass

	return


func _on_attack_timer_timeout() -> void:
	$attack_timer.stop()
	# Block animations while attacking
	attack_ip = false
	# Apply damage to the enemy
	global.player_current_attack = false


func _on_hp_regeneration_timer_timeout() -> void:
	if player_hp < 100:
		player_hp += 10
		if 100 < player_hp:
			player_hp = 100
	elif player_hp <= 0:
		player_hp = 0
