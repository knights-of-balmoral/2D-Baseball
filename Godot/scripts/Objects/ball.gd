extends KinematicBody2D
onready var anim = get_node("anim_ball")

func _physics_process(delta): # delta times things with clock/render cycle
	
	# If ball hasn't been pitched, pitch it
	if Input.is_action_pressed("pitch_ball") && globals.ball_status == "P":
		anim.play("fastball") #replace with a pitch selection function
		globals.ball_status = "Pitched"
		# $console_log.text = str(ball_timer)
	
	# when pitch is over, allow new pitch
	if $anim_ball.current_animation_position == 0.5:
		globals.ball_status = "P" #PITCHER for now - but will need some update functions
		# $console_log.text = str(ball_timer)
	

