extends Node2D
onready var ui_balls = get_node("batter_view/UI/scoreboard/balls_display")
onready var ui_strikes = get_node("batter_view/UI/scoreboard/strikes_display")
onready var ui_out_1 = get_node("batter_view/UI/scoreboard/out_1")
onready var ui_out_2 = get_node("batter_view/UI/scoreboard/out_2")
onready var si_strike = get_node("batter_view/Sound/strike")
onready var si_ball = get_node("batter_view/Sound/ball")
onready var si_hbp = get_node("batter_view/Sound/hitByPitch")
onready var si_gc = get_node("batter_view/Sound/glove_catch")
onready var anim_pitch = get_node("batter_view/ball_group/anim_ball")
onready var batter_anim = get_node("batter_view/batter/anim_batter")

func _ready():
	globals.bg_fans.play()
	globals.bg_fans.volume_db = -30
	
func _process(delta):
# Toggle Menu 
	if Input.is_action_just_released("toggle_menu") == true:
		get_tree().change_scene("res://scenes/mainMenu.tscn")
#------------------------------------	
# Batter Idle Animations	
	if(Input.is_action_pressed("swing_bat")):
		batter_anim.play("swing")
	else:
		batter_anim.play("idle")
		globals.swing_target = "idle"
#------------------------------------
# Pitcher Idle Animations

# BALL PITCHED
	if globals.ball_status == "PITCHED":
		batter_anim.play("idle") # Reset better animations in case mid-practice-swing
		animatePitch()
	
		# BAT SWUNG (handle HIT)
		if(Input.is_action_pressed("swing_bat")):
			batter_anim.play("swing")
			# Compute hit result
			globals.ball_status = "IP" #yields a hit every swing right now
			get_tree().change_scene('res://scenes/field_overhead.tscn')
			
		# BAT NOT SWUNG (handle no swing)
		else:
			# check for end of animation
			if anim_pitch.current_animation_position >= 0.9:
				si_gc.play()
				globals.ball_status = "P" #PITCHER for now - but will need some update functions
				
				
				match globals.pitch_potential_result:
					0,1,2,3,4,5,6,7,8:
						updateStrikes()
						si_strike.play() 
						
					9,10,11,12,13,14,15,16:
						updateBalls()
						si_ball.play()
				
				globals.pitch_potential_result = ""
				updateUI()

					
func updateStrikes():
	if globals.strikes >= 2:
		globals.strikes = 0
		globals.balls = 0
		
		updateOuts()
	else:
		globals.strikes += 1
		

func updateBalls():
	if globals.balls >= 3:
		globals.balls = 0
		globals.strikes = 0
		
		updateRunners()
	else:
		globals.balls += 1
		
		
func updateOuts():
	if globals.outs > 2:
		globals.outs = 0
		
		updateInnings()
	else:
		globals.outs += 1
		
	
func updateInnings():
	# need to update for bottom and top of innings
	updateScores()
	if globals.inning > 9:
		displayGameResult()
	else:
		globals.team_at_bat = !globals.team_at_bat

func updateScores():
	pass
	
func updateWildPitch():
	pass
	
func updateHitByPitch():
	globals.balls = 0
	globals.strikes = 0
	
func displayGameResult():
	pass
	
func updateRunners():
	pass

func updateUI():
	ui_balls.text = str(globals.balls)
	ui_strikes.text = str(globals.strikes)
	
	# Handle the display of outs
	if globals.outs == 0:
		ui_out_1.visible = false
		ui_out_2.visible = false
	elif globals.outs == 1:
		ui_out_1.visible = true
		ui_out_2.visible = false
	elif globals.outs == 2:
		ui_out_1.visible = true
		ui_out_2.visible = true
	else:
		ui_out_1.visible = false
		ui_out_2.visible = false	
		
func animatePitch():
	anim_pitch.playback_speed = globals.pitch_strength
	anim_pitch.play(globals.pitch_target)	