extends Node

var current_scene = "world"
var transition_scene: bool = false
var game_first_loading: bool = true

var player_start_position_x = 199
var player_start_position_y = 24

var player_exit_position_x = 186
var player_exit_position_y = 206

var player_current_attack: bool = false

func finish_change_scenes() -> void:
	if transition_scene:
		transition_scene = !transition_scene
		if current_scene == "world":
			current_scene = "camp"
		else:
			current_scene = "world"
	return
