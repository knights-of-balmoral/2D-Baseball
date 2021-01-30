# KNOWN BUGS
# 1. Bottom of inning indicator is currently utilizing 
# dupe code in the ready function of the scoreboard

extends Node2D
onready var ui_balls = get_node("batter_view/UI/scoreboard/balls_display")
onready var ui_strikes = get_node("batter_view/UI/scoreboard/strikes_display")
onready var ui_out_1 = get_node("batter_view/UI/scoreboard/out_1")
onready var ui_out_2 = get_node("batter_view/UI/scoreboard/out_2")
onready var ui_strike_zone = get_node("batter_view/UI/strikezone")
onready var ui_inning = get_node("batter_view/UI/scoreboard/inning")
onready var v_score = get_node("batter_view/UI/scoreboard/v_score")
onready var h_score = get_node("batter_view/UI/scoreboard/h_score")
onready var ui_pitch_count = get_node("batter_view/UI/scoreboard/pitch_count")
onready var ui_top = get_node("batter_view/UI/scoreboard/top_inning")
onready var ui_bottom = get_node("batter_view/UI/scoreboard/bottom_inning")
onready var ui_base_1 = get_node("batter_view/UI/scoreboard/base_1")
onready var ui_base_2 = get_node("batter_view/UI/scoreboard/base_2")
onready var ui_base_3 = get_node("batter_view/UI/scoreboard/base_3")
onready var si_strike = get_node("batter_view/Sound/s_strike")
onready var si_ball = get_node("batter_view/Sound/s_ball")
onready var si_hbp = get_node("batter_view/Sound/s_hit_by_pitch")
onready var si_gc = get_node("batter_view/Sound/s_glove_catch")
onready var anim_ball = get_node("batter_view/ball_group/anim_ball")
onready var batter_anim = get_node("batter_view/batter/anim_batter")
onready var pitcher_anim = get_node("batter_view/pitcher/anim_pitcher")


var batter_swung = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	update_ui()
	globals.game_state.ball_status = "P"
	
func _process(delta):
#------------- Batter Idle Animation -----------
	if(Input.is_action_pressed("swing_bat")):
		batter_anim.play("swing")
	else:
		batter_anim.play("idle")
		globals.swing_target = "idle"
#-----------------------------------------------

#------------- Ball Pitched -----------
	if globals.game_state.ball_status == "PITCHED":
		animateBall()
		
		#---------  Swing and miss ----------
		if(Input.is_action_just_pressed("swing_bat")) && anim_ball.current_animation_position < globals.swing_window_min:
			batter_anim.play("swing")
			batter_swung = true
			updateStrikes()
			update_pitch_count()
			update_ui()
		
		# -------- Swing and hit ------------
		if(Input.is_action_just_pressed("swing_bat")) && anim_ball.current_animation_position >= globals.swing_window_min && anim_ball.current_animation_position < globals.swing_window_max:
			batter_anim.play("swing")
			globals.game_state.ball_status = "H" # Hit
			update_pitch_count()
			get_tree().change_scene('res://scenes/field_overhead.tscn')
		# -------- Bat not swung ------------	
		else: 
			# check for end of animation
			if anim_ball.current_animation_position >= 0.9:
				si_gc.play()
				updateStrikes()
				update_pitch_count()
				globals.game_state.ball_status = "P" #PITCHER for now - but will need some update functions
				update_ui()

func updateStrikes():
	if globals.game_state.strikes >= 2:
		globals.game_state.strikes = 0
		globals.game_state.balls = 0
		updateOuts()
	else:
		globals.game_state.strikes += 1
		si_strike.play() 

func updateBalls():
	if batter_swung == false:
		if globals.game_state.balls >= 3:
			globals.game_state.balls = 0
			globals.game_state.strikes = 0
			updateRunners()
		else:
			globals.game_state.balls += 1
			si_ball.play()
	else:
		batter_swung = false
		updateStrikes()

func updateOuts():
	if globals.game_state.outs >= 2:
		globals.game_state.outs = 0
		updateInnings()
	else:
		globals.game_state.outs += 1

func updateInnings():
	globals.game_state.inning_marker += 0.5
	match globals.game_state.inning_marker:
		# start game
		1.5:
			go_to_bottom()
			print ('supposed to go to bottom')
		2.0:
			globals.game_state.inning = 2
			go_to_top()
			print ('back to top')
		2.5:
			go_to_bottom()
		3.0:
			globals.game_state.inning = 3
			go_to_top()
		3.5:
			go_to_bottom()
		4.0:
			globals.game_state.inning = 4
			go_to_top()
		4.5:
			go_to_bottom()
		5.0:
			globals.game_state.inning = 5
			go_to_top()
		5.5:
			go_to_bottom()
		6.0:
			globals.game_state.inning = 6
			go_to_top()
		6.5:
			go_to_bottom()
		7.0:
			globals.game_state.inning = 7
			go_to_top()
		7.5:
			go_to_bottom()
		8.0:
			globals.game_state.inning = 8
			go_to_top()
		8.5:
			go_to_bottom()
		9.0:
			globals.game_state.inning = 9
			go_to_top()
		9.5:
			go_to_bottom()
		_:
			print ("error in inning incrementation or extra innings")
			
	if globals.game_state.inning > 9:
		check_for_end_of_game()
		
	update_ui()
	get_tree().change_scene("res://scenes/team_transition.tscn")

func go_to_top():
	ui_top.visible = true
	ui_bottom.visible = false
	globals.game_state.team_at_bat = "V"

func go_to_bottom():
	ui_top.visible = false
	ui_bottom.visible = true
	globals.game_state.team_at_bat = "H"

func update_scoreboard():
	pass
	
func updateWildPitch():
	pass
	
func updateHitByPitch():
	globals.game_state.balls = 0
	globals.game_state.strikes = 0
	
func check_for_end_of_game():
	pass
	
func updateRunners():
	pass

func update_pitch_count():
	if globals.game_state.team_at_bat == "V":
		globals.game_state.v_pitch_count += 1
	else:
		globals.game_state.h_pitch_count += 1

func update_ui():
	# Handle the display of outs
	if globals.game_state.outs == 0:
		ui_out_1.visible = false
		ui_out_2.visible = false
	elif globals.game_state.outs == 1:
		ui_out_1.visible = true
		ui_out_2.visible = false
	elif globals.game_state.outs == 2:
		ui_out_1.visible = true
		ui_out_2.visible = true
	else:
		ui_out_1.visible = false
		ui_out_2.visible = false	
	
	ui_balls.text = str(globals.game_state.balls)
	ui_strikes.text = str(globals.game_state.strikes)
	ui_inning.text = str(globals.game_state.inning)
	v_score.text = str(globals.game_state.v_score)
	h_score.text = str(globals.game_state.h_score)
	
	if globals.game_state.team_at_bat == "V":
		ui_pitch_count.text = str(globals.game_state.v_pitch_count)
	else:
		ui_pitch_count.text = str(globals.game_state.h_pitch_count)

func animateBall():
	anim_ball.playback_speed = globals.pitch_strength
	anim_ball.play(globals.pitch_target)

func _on_anim_ball_animation_finished(anim_name):
	globals.game_state.ball_status = "P"
