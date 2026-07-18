extends CharacterBody2D

const speed =100
var current_direction = "none"

func _ready():
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
		#current_direction = "none"
		play_animation(false)
		velocity.x = 0
		velocity.y = 0

	move_and_slide()
	
	
func play_animation(movement: bool) -> void:
	var direction = current_direction
	var animation = $AnimatedSprite2D
	
	if direction == "right":
		animation.flip_h = false
		if movement == true:
			animation.play("side_walk")
		elif movement == false:
			animation.play("side_idle")
	
	if direction == "left":
		animation.flip_h = true
		if movement == true:
			animation.play("side_walk")
		elif movement == false:
			animation.play("side_idle")
	
	if direction == "up":
		animation.flip_h = false
		if movement == true:
			animation.play("back_walk")
		elif movement == false:
			animation.play("back_idle")
	
	if direction == "down":
		animation.flip_h = false
		if movement == true:
			animation.play("front_walk")
		elif movement == false:
			animation.play("front_idle")
