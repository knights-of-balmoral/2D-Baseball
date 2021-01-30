extends Node2D
onready var v_team = $v_team_name
onready var h_team = $h_team_name
onready var ui_top = $top_inning
onready var ui_bottom = $bottom_inning

func _ready():
	v_team.text = globals.game_state.v_team_name
	h_team.text = globals.game_state.h_team_name
	$v_score.text = str(globals.game_state.v_score)
	$h_score.text = str(globals.game_state.h_score)
	$inning.text = str(globals.game_state.inning)
	
	if globals.game_state.team_at_bat == "V":
		ui_top.visible = true
		ui_bottom.visible = false
	else:
		ui_top.visible = false
		ui_bottom.visible = true
	


