extends Node2D

func _ready() -> void:
	if global.game_first_loading:
		$player.position.x = global.player_start_position_x
		$player.position.y = global.player_start_position_y
	else:
		$player.position.x = global.player_exit_position_x
		$player.position.y = global.player_exit_position_y
	return

func _process(delta: float) -> void:
	change_scene()
	return
	
func change_scene():
	if global.transition_scene:
		if global.current_scene == "world":
			get_tree().change_scene_to_file("res://scenes/camp.tscn")
			global.game_first_loading = false
			global.finish_change_scenes()
	return

func _on_camp_exit_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene = true
	return
