extends Node2D
onready var v = $v_team
onready var h = $h_team


func _ready():
	globals.game_state.balls = 0
	globals.game_state.strikes = 0
	globals.game_state.inning = 1
	globals.game_state.team_at_bat = "V"
	v.text = globals.game_state.v_team_name
	h.text = globals.game_state.h_team_name

func _on_btn_play_pressed():
	get_tree().change_scene("res://scenes/team_transition.tscn")
