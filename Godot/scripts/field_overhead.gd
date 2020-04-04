extends Node2D
onready var anim = get_node("anim_ball_in_play/anim_start_point/ball_in_play")
onready var sp = get_node("anim_ball_in_play/anim_start_point")
onready var ball_shadow = get_node("anim_ball_in_play/anim_start_point/ball_shadow")

func _ready():
	pass
	
func _process(delta):
	
	# See if players presses menu key
	if Input.is_action_just_released("toggle_menu") == true:
		get_tree().change_scene("res://scenes/mainMenu.tscn")
		globals.ball_status = "P"
	
	# If the ball is hit
	if globals.ball_status == "IP":
		globals.ball_x = calculateBallX()
		globals.ball_y = calculateBallY()
		globals.ball_status = "AIR"
		# default ball start = 540,500
		# get ball velocity
		# get ball direction
		# get ball endpoint
		
	if globals.ball_status == "AIR":	
		anim.playback_speed = 0.75
		anim.play("line_drive")
		
		# transform from the starting point of the animation
		sp.position.y -= globals.ball_y
		sp.position.x += globals.ball_x
		
		if anim.current_animation_position >= 1.9:
			anim.stop()
			ball_shadow.position.x = sp.position.x
			ball_shadow.position.y = sp.position.y
		
func calculateBallY():
	randomize()
	var num = randf()*1 + 1 # Y will most likely be always subtracted unless it's a foul ball straight back
	return num
	
func calculateBallX():
	randomize()
	var num = randf()*1 + 1 # X needs to be either positive or negative
	var horizontal_shifter = randi()%2 + 1
	if horizontal_shifter <= 1:
		num *= -1
	
	return num

func hit_animation():
	var anim_matrix = ["line_drive","line_drive", "pop_fly", "foul_ball"] 
	var rand = randi()%3 + 1
	globals.ball_location.x = 100
	globals.ball_location.y = 100
	return anim_matrix[rand]

