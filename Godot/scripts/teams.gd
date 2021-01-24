extends Node2D

func _ready():
	globals.game_state.balls = 0
	globals.game_state.strikes = 0
	globals.game_state.inning = 1
	globals.game_state.team_at_bat = "V"

func _on_btn_play_pressed():
	get_tree().change_scene('res://scenes/battingView.tscn')
