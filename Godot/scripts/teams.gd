extends Node2D
onready var v = $v_team
onready var h = $h_team


func _ready():
	globals._state.balls = 0
	globals._state.strikes = 0
	globals._state.inning = 1
	globals._state.team_at_bat = "V"
	v.text = globals._state.v_team_name
	h.text = globals._state.h_team_name

func _on_btn_play_pressed():
	get_tree().change_scene("res://scenes/team_transition.tscn")
