extends KinematicBody2D
onready var anim = get_node("anim_batter")
var velocity: = Vector2.ZERO # start with no velocity
var speed: = 200
var batterPositionRange: = 400
var bat_state = "idle"

func _physics_process(delta): # delta times things with clock/render cycle
	
	velocity.x = (Input.get_action_strength("move_right") - Input.get_action_strength("move_left")) * speed
	velocity.y = (Input.get_action_strength("move_down") - Input.get_action_strength("move_up")) * speed
	
	if velocity.x >= batterPositionRange:
		velocity.x = velocity.x - 1
	
	if velocity.y >= batterPositionRange:
		velocity.y = velocity.y - 1
	
	velocity = move_and_slide(velocity)  # delta auto in move and slide function
	
	if(Input.is_action_pressed("swing_bat")):
		anim.play("swing")
		bat_state = "swing"
		
	else:
		anim.play("idle")
		bat_state = "idle"
		