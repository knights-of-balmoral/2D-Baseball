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
	randomize() # to be removed 
	var random_hit = randi()%2+1
	ball_animation.sleeping = false
	playback = get("parameters/playback")
	
	# to be removed with better simulation
	match random_hit:
		
		1:
			playback.start("hit")
		
		2:
			playback.start("grounder")
			
		_:
			playback.start("hit")
	
func _process(delta):
	
	
	if status_sent < 3:
		match playback.get_current_node():
		
			"hit":
				
				if status_sent == 0:
					field_physics.linear_damp = 0
					print("It's in the Air!")
					status_sent += 1
					
			"grounder":
				if status_sent == 0:
					field_physics.linear_damp = 0.5
					print("Grounder!")
					status_sent += 1
		
			"roll":
				
				if status_sent == 1:
					field_physics.linear_damp = 0.75
					print("ball is rolling")
					status_sent += 1
					
				
			"idle":
				if status_sent == 2:
					print("it finally stopped rolling")
					status_sent = 0
					#ball_animation.sleeping = true
					
				
		
	
