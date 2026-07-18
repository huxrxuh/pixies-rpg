extends Node2D

func _process(delta: float) -> void:
	change_scene()
	


func change_scene():
	if global.transition_scene:
		if global.current_scene == "camp":
			get_tree().change_scene_to_file("res://scenes/world.tscn")
			global.game_first_loading = false
			global.finish_change_scenes()


func _on_world_exit_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		global.transition_scene = true
