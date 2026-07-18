extends CharacterBody2D

const speed = 70
var current_direction = "none"

func player() -> void:
	pass

func _ready() -> void:
	$AnimatedSprite2D.play("front_idle")

func _physics_process(delta: float) -> void:
	player_movement(delta)

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
	
	
func play_animation(movement: bool) -> void:
	var direction = current_direction
	var animation = $AnimatedSprite2D
	
	if direction == "right":
		animation.flip_h = false
		if movement:
			animation.play("side_walk")
		else:
			animation.play("side_idle")
	
	if direction == "left":
		animation.flip_h = true
		if movement:
			animation.play("side_walk")
		else:
			animation.play("side_idle")
	
	if direction == "up":
		animation.flip_h = false
		if movement:
			animation.play("back_walk")
		else:
			animation.play("back_idle")
	
	if direction == "down":
		animation.flip_h = false
		if movement:
			animation.play("front_walk")
		else:
			animation.play("front_idle")
