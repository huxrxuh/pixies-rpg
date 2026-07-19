extends CharacterBody2D

var speed = 50
var player_chase: bool = false
var player = null

var slime_hp: int = 100
var can_take_damage: bool = true

var player_attack_range: bool = false

func slime() -> void:
	return

func _ready() -> void:
	$AnimatedSprite2D.play("idle_front")
	return

func _physics_process(delta: float) -> void:
	
	deal_with_damage()
	
	if player_chase:
		# print("chasing!")
		position += (player.position - position) / 50
		
		$AnimatedSprite2D.play("walk_side")
		if (player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
		
	else:
		# print("zzz")
		$AnimatedSprite2D.play("idle_front")
	
	move_and_slide()
	return

func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):	
		player = body
		player_chase = true
	return

func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player = null
		player_chase = false
	return


func _on_player_attack_range_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_attack_range = true
	return


func _on_player_attack_range_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_attack_range = false
	return
		
func deal_with_damage() -> void:
	# is the player attacking and within range
	if global.player_current_attack and player_attack_range:
		if can_take_damage:
			can_take_damage = false
			$slime_damage_cooldown.start()
			slime_hp -= 35
			print(slime_hp)
			
			if slime_hp <= 0:
				# Destroy object
				self.queue_free()
	return


func _on_slime_damage_cooldown_timeout() -> void:
	$slime_damage_cooldown.stop()
	can_take_damage = true
