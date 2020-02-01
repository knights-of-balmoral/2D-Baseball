extends KinematicBody2D
class_name Pitcher

var velocity: = Vector2.ZERO # start with no velocity
var speed: = 100
var pitcherPositionRange: = 400
var ballIsPitched = false


func _physics_process(delta): # delta times things with clock/render cycle
	
	velocity.x = (Input.get_action_strength("pitcher_move_right") - Input.get_action_strength("pitcher_move_left")) * speed
	if velocity.x >= pitcherPositionRange:
		velocity.x = velocity.x - 1
	velocity = move_and_slide(velocity)  # delta auto in move and slide function
	
	if Input.is_action_pressed("pitch_ball"):
		ballIsPitched = true
		$AnimationPlayer.play("fade_in")
		
		
		