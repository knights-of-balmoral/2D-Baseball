extends Node2D
onready var anim = get_node("anim_ball_in_play/anim_start_point/ball_in_play")
onready var ball_pos = get_node("anim_ball_in_play/anim_start_point")
onready var ball_shadow = get_node("anim_ball_in_play/anim_start_point/ball_shadow")
onready var lbl_ball_pos = get_node("anim_ball_in_play/anim_start_point/coords") # default ball start = 540,520


func _ready():
	# get ball direction
	globals.ball_x = calcBallX()
	globals.ball_y = calcBallY()
	# get ball velocity
	globals.ball_speed = calcBallVelocity()
	# get ball endpoint
	##
	
	# If the ball is hit
	if globals.ball_status == "IP":
		globals.ball_status = "AIR"
		anim.playback_speed = globals.ball_speed
		anim.play("line_drive")

func _process(delta):
	lbl_ball_pos.text = "Pos:" + str(ball_pos.position)
	# See if player presses menu key
	if Input.is_action_just_released("toggle_menu") == true:
		get_tree().change_scene("res://scenes/mainMenu.tscn")
		globals.ball_status = "P"
	
	if globals.ball_status == "AIR":
		# transform the position of the animation
		ball_pos.position.y -= globals.ball_y
		ball_pos.position.x += globals.ball_x 
	
	if anim.current_animation_position >= 1.9:
			ball_shadow.position.x = ball_pos.position.x
			ball_shadow.position.y = ball_pos.position.y
			globals.ball_status = "P" #"END"

		
func calcBallY():
	randomize()
	var num = randf()*1 + 1 # Y will most likely be always subtracted unless it's a foul ball straight back
	return num
	
func calcBallX():
	randomize()
	var num = randf()*1 + 1 
	
	# X needs to be either positive or negative and sometimes zero
	var horizontal_shifter = randi()%3 + 1
	if horizontal_shifter <= 1:
		num *= -1
	elif horizontal_shifter >= 3:
		num = 0
	else: 
		num = 2
		
	
	return num 

func calcBallVelocity():
	randomize()
	var num = randf()*1 + 1
	return num
	
func hit_animation():
	var anim_matrix = ["line_drive","line_drive", "pop_fly", "foul_ball"] 
	var rand = randi()%3 + 1
	globals.ball_location.x = 100
	globals.ball_location.y = 100
	return anim_matrix[rand]

