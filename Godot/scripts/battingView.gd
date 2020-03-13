extends Node2D
onready var ui_balls = get_node("batter_view/UI/scoreboard/score_balls/balls_display")
onready var ui_strikes = get_node("batter_view/UI/scoreboard/score_strikes/strikes_display")
onready var ui_outs = get_node("batter_view/UI/scoreboard/score_outs/outs_display")
onready var si_strike = get_node("batter_view/Sound/strike")
onready var anim = get_node("batter_view/ball/anim_ball")
onready var batter_anim = get_node("batter_view/batter/anim_batter")

func _process(delta):
	if Input.is_action_just_released("toggle_menu") == true:
		get_tree().change_scene("res://scenes/mainMenu.tscn")
	
# Batter Idle Animations	
	if(Input.is_action_pressed("swing_bat")):
		batter_anim.play("swing")
		globals.swing_location = "SC" # Swing Center
	else:
		batter_anim.play("idle")
		globals.swing_location = "idle"

# Pitcher Idle Animations

# BALL PITCHED
	if globals.ball_status == "Pitched":
	
		# BAT SWUNG
		if globals.swing_location != "idle":
			globals.ball_status = "IP" #yields a hit every swing right now
			get_tree().change_scene('res://scenes/field_overhead.tscn')
			
		# BAT NOT SWUNG
		elif globals.swing_location == "idle" && globals.pitch_location == "S":
			
			# Update Strikes & Outs (consider breaking out into functions)
			globals.strikes += 1
			ui_strikes.text = str(globals.strikes)
			globals.pitch_location = "PC"
			
			# when pitch is over, allow new pitch
			if anim.current_animation_position == 0.5:
				globals.ball_status = "P" #PITCHER for now - but will need some update functions
				si_strike.play()
			
			if globals.strikes == 3:
				globals.strikes = 0
				globals.outs += 1
								
				if globals.outs == 3:
					globals.outs = 0
					# Change who is batting
					globals.team_at_bat = !globals.team_at_bat
			