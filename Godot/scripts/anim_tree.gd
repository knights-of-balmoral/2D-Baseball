extends AnimationTree
var playback : AnimationNodeStateMachinePlayback
var status_sent = 0
# status 0 - not sent
#  0 - hit - 1
#  1 - rolling - 2
#  2 - idle - 0
onready var field_physics = get_node("../../physics/infield_dirt")
onready var ball_animation = get_parent()

func _ready():
	ball_animation.sleeping = false
	playback = get("parameters/playback")
	playback.start("hit")
	
func _process(delta):
	
	
	if status_sent < 3:
		match playback.get_current_node():
		
			"hit":
				
				if status_sent == 0:
					field_physics.linear_damp = 0
					print("it's in the air")
					status_sent += 1
					
		
			"roll":
				
				if status_sent == 1:
					field_physics.linear_damp = 1
					print("ball is rolling")
					status_sent += 1
					
				
			"idle":
				if status_sent == 2:
					print("it finally stopped rolling")
					status_sent = 0
					ball_animation.sleeping = true
					
				
		
	
