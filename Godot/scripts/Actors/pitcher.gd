extends KinematicBody2D
class_name Pitcher
onready var anim = get_node("../ball/anim_ball")
onready var ui_status = get_node("../UI/scoreboard/status/status_display")
var velocity: = Vector2.ZERO # start with no velocity
var speed: = 100
var pitcherPositionRange: = 400


func _physics_process(delta): # delta times things with clock/render cycle
	
	velocity.x = (Input.get_action_strength("pitcher_move_right") - Input.get_action_strength("pitcher_move_left")) * speed
	if velocity.x >= pitcherPositionRange:
		velocity.x = velocity.x - 1
	velocity = move_and_slide(velocity)  # delta auto in move and slide function
	
	# If ball hasn't been pitched, pitch it
	if Input.is_action_pressed("pitch_ball") && globals.ball_status == "P":
		globals.pitch_potential_result = pitchComputation(globals.pitch_target)
		anim.play("fastball") #replace with a pitch selection function
		globals.ball_status = "PITCHED"
		# $console_log.text = str(ball_timer)
	


	
func pitchComputation(target): #accepts where pitcher aimed and then calculates result
	var random_pitch = randi()%4 + 1 # replace with pitch logic
	
	match random_pitch:
		1: 
			ui_status.text = "Strike"	
			return "S"
		2: 
			ui_status.text = "Ball"	
			return "B"
		3: 
			ui_status.text = "Wild Pitch"	
			return "W"
		4: 
			ui_status.text = "Hit Batter"	
			return "HBP"
	
	
		
		
		