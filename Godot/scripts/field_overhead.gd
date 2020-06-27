extends Node2D
onready var anim = get_node("anim_position/ball_in_play")
onready var ball_pos = get_node("anim_position")
onready var lbl_ball_pos = get_node("anim_position/coords") # default ball start = 540,520
onready var ball_current_location = ball_pos.position
onready var ball = get_node("field/ball")
var ball_destination = Vector2(0, 0)
var direction = Vector2()
##var num = randf()*1 + 1 # Y will most likely be always subtracted unless it's a foul ball straight back


func _ready():
	# get ball direction
	direction = calcBallDirection()
	# get ball velocity
	globals.ball_speed = calcBallVelocity()
	# get ball endpoint
	ball_destination = calcBallDestination()
	# Play the animatio if the ball is hit
	if globals.ball_status == "IP":
		globals.ball_status = "AIR"
		anim.playback_speed = globals.ball_speed
		anim.play("line_drive")
		
		

func _process(delta):
	
	move_ball(delta)

func calcBallDirection():
	pass

func calcBallVelocity():
	randomize()
	var num = randf()*1 + 1
	return num
	
func calcBallDestination():
	randomize()
	var new_x = randf()*300 + 1
	var new_y = randf()*300 + 1
	return Vector2(new_x, new_y) 

func move_ball(delta):
	#ball.position.y -= globals.ball_speed
	pass	
	


