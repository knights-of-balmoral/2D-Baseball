extends KinematicBody2D
class_name Ball
onready var anim = get_node("anim_ball")
var velocity: = Vector2.ZERO # start with no velocity
var speed: = 400
var batterPositionRange: = 400
var ballState: = bool(false)

func _physics_process(delta): # delta times things with clock/render cycle
	
	# If ball hasn't been pitched, pitch it
	if Input.is_action_pressed("pitch_ball"):
		anim.play("fastball")
	
	
