extends KinematicBody2D
onready var anim = get_node("anim_ball")
var pitched = false
#intended for pitch location selection in the future
var pitch_location = "PC" #["PTL", "PTC", "PTR", "PLC", "PC", "PRC", "PBL", "PBC", "PBR"]
var swing_location = "SC" #["STL", "STC", "STR", "SLC", "SC", "SRC", "SBL","SBC", "SBR"]

var hit_location = 0 # range from 0 - 110 to decide hit's location (0-10 foul left/back), (100,110 foul rightback)

func hitter_results(pitch_location, swing_location, ball_status):
	# match statement but possibly put this function in the overhead view as that is where hits are shown
	pass

func _physics_process(delta): # delta times things with clock/render cycle
	
	# If ball hasn't been pitched, pitch it
	if Input.is_action_pressed("pitch_ball") && pitched == false:
		anim.play("fastball") #replace with a pitch selection function
		pitched = true
		# $console_log.text = str(ball_timer)
	
	
	
	# when pitch is over, allow new pitch
	if $anim_ball.current_animation_position == 0.5:
		pitched	= false
		# $console_log.text = str(ball_timer)
	

