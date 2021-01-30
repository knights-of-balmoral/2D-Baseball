extends AnimationTree
onready var fence = get_node("/root/OverheadView/field/field_obstacles/outfield_fence")
onready var foul_area_fence = get_node("/root/OverheadView/field/spray_chart/foul_area")
onready var field_overhead = get_node("/root/OverheadView")
var playback : AnimationNodeStateMachinePlayback
var status_sent = 0
# status 0 - not sent
#  0 - hit - 1
#  1 - rolling - 2
#  2 - idle - 0

var catchable = true

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
					#fence.disabled = true [O]
					fence.set_deferred("disabled", true)
					foul_area_fence.set_deferred("disabled", true)
					print("Catchable!") # to be split into 1. high in the air, 2. catchable
					status_sent += 1
					field_overhead.disable_colliders()
					
			"pop_up":
				if status_sent == 0:
					fence.set_deferred("disabled", true)
					foul_area_fence.set_deferred("disabled", true)
					print("It's in the Air!")
					status_sent += 1
					field_overhead.disable_colliders()
			
			"catchable":
				if catchable && globals.game_state.ball_status != "HR":
					print("CATCH IT!")
					field_overhead.enable_colliders()
					catchable = false
					
			"grounder":
				if status_sent == 0:
					fence.set_deferred("disabled", false)
					foul_area_fence.set_deferred("disabled", false)
					print("Grounder!")
					status_sent += 1
		
			"roll":
				if status_sent == 1:
					fence.set_deferred("disabled", false)
					foul_area_fence.set_deferred("disabled", false)
					print("ball is rolling")
					status_sent += 1
					
			"idle":
				if status_sent == 2:
					fence.set_deferred("disabled", false)
					foul_area_fence.set_deferred("disabled", false)
					print("it finally stopped rolling")
					status_sent = 0

