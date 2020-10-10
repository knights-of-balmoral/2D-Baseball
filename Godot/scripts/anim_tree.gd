extends AnimationTree
onready var fence = get_node("/root/OverheadView/field/field_obstacles/outfield_fence")
onready var foul_area_fence = get_node("/root/OverheadView/field/field_obstacles/foul_area_fence")
var playback : AnimationNodeStateMachinePlayback
var status_sent = 0
# status 0 - not sent
#  0 - hit - 1
#  1 - rolling - 2
#  2 - idle - 0

onready var ball_animation = get_parent()

func _ready():
	
	randomize() # to be removed 
	var random_hit = randi()%3+1
	playback = get("parameters/playback")
	
	# to be removed with better simulation
	match random_hit:
		1:
			playback.start("hit")
		2:
			playback.start("grounder")
		3:
			playback.start("pop_up")
		_:
			playback.start("hit")
	
func _process(delta):
	
	if status_sent < 3:
		match playback.get_current_node():
		
			"hit":
				if status_sent == 0:
					#field_physics.linear_damp = 0
					#field_physics.angular_damp = 0
					fence.disabled = true
					foul_area_fence.disabled = true
					#print("It's in the Air!")
					status_sent += 1
					
			"pop_up":
				if status_sent == 0:
					#field_physics.linear_damp = 0
					#field_physics.angular_damp = 0
					fence.disabled = true
					foul_area_fence.disabled = true
					#print("It's in the Air!")
					status_sent += 1
					
			"grounder":
				if status_sent == 0:
					fence.disabled = false
					foul_area_fence.disabled = false
					#field_physics.linear_damp = 0.5
					#field_physics.angular_damp = 0.5
					#print("Grounder!")
					status_sent += 1
		
			"roll":
				if status_sent == 1:
					fence.disabled = false
					foul_area_fence.disabled = false
					#field_physics.linear_damp = 0.75
					#field_physics.angular_damp = 1
					#print("ball is rolling")
					status_sent += 1
					
			"idle":
				if status_sent == 2:
					fence.disabled = false
					foul_area_fence.disabled = false
					#field_physics.linear_damp = 1
					#field_physics.angular_damp = 1
					#print("it finally stopped rolling")
					status_sent = 0
					#ball_animation.sleeping = true
					
				
		
	
