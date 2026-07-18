extends Node

var current_scene = "world"
var transition_scene = false
var game_first_loading = true

var player_start_position_x = 199
var player_start_position_y = 24

var player_exit_position_x = 186
var player_exit_position_y = 206

func finish_change_scenes():
	if transition_scene:
		transition_scene = !transition_scene
		if current_scene == "world":
			current_scene = "camp"
		else:
			current_scene = "world"
