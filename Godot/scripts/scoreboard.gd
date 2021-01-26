extends Node2D
onready var v_team = $v_team_name
onready var h_team = $h_team_name


func _ready():
	v_team.text = globals.game_state.v_team_name
	h_team.text = globals.game_state.h_team_name
	$v_score.text = str(globals.game_state.v_score)
	$h_score.text = str(globals.game_state.h_score)
	


