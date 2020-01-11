extends KinematicBody2D
class_name Ball

var velocity: = Vector2.ZERO # start with no velocity
var speed: = 400
var batterPositionRange: = 400
var ballState: = bool(false)

func _physics_process(delta): # delta times things with clock/render cycle
	
	# If ball hasn't been pitched, pitch it
	if Input.get_action_strength("pitch_ball") and !ballState:
		ballState = false
	
	velocity = move_and_slide(velocity)  # delta auto in move and slide function
