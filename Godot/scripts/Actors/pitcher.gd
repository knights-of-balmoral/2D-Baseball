extends KinematicBody2D
class_name Pitcher

onready var anim_pitcher = get_node("anim_pitcher")


var velocity: = Vector2.ZERO # start with no velocity
var speed: = 100
var pitcherPositionRange: = 400


func _physics_process(delta): # delta times things with clock/render cycle
	
	velocity.x = (Input.get_action_strength("pitcher_move_right") - Input.get_action_strength("pitcher_move_left")) * speed
	if velocity.x >= pitcherPositionRange:
		velocity.x = velocity.x - 1
	velocity = move_and_slide(velocity)  # delta auto in move and slide function
	
		
	# If ball hasn't been pitched, pitch it
	if Input.is_action_just_pressed("pitch_ball") && globals.ball_status == "P":
		globals.pitch_potential_result = pitchComputation() #replace with a pitch selection function
		anim_pitcher.play("pitch_motion")
		
func pitchComputation(): #accepts where pitcher aimed and then calculates result
	# These are the different animations possible for a fastball
	var pitch_matrix = ["fastball_target_1","fastball_target_2","fastball_target_3","fastball_target_4",
	"fastball_target_5","fastball_target_6","fastball_target_7","fastball_target_8","fastball_target_9",
	"fastball_target_11","fastball_target_11_5","fastball_target_12","fastball_target_12_5","fastball_target_13",
	"fastball_target_13_5","fastball_target_14"]
	var random_pitch = randi()%16 # replace with pitch logic
	var random_speed = randf()*2 + 1 # pitch speed

	globals.pitch_target = str(pitch_matrix[random_pitch])
	globals.pitch_strength = random_speed
	return random_pitch

func _on_anim_pitcher_animation_finished():
		if anim_pitcher.animation == "idle":
			pass
		else:
			globals.ball_status = "PITCHED"
			anim_pitcher.play("idle")
