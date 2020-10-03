extends RigidBody2D
var speed = globals.ball_speed
var ball_has_been_hit = false
var ball_english = Vector2(0,0) # selects "origin" - like where cue ball is hit (english)
var ball_origin = Vector2(544, 300)
onready var anim = get_node("anim")
onready var ball = get_node("../ball")
onready var foul_banner = get_node("../ui_canvas/ui/foul")
onready var home_run_banner = get_node("../ui_canvas/ui/home_run")
onready var home_run_distance = get_node("../ui_canvas/ui/home_run/distance")
#onready var uiCam = get_node("../../uiCamera")
#randi()%10+1 returns an int from 1 to 10
#randf()*10.0+1.0 returns a float from 1.0 to 10.999999~
#rand_range(1,11) returns a float from 1.0 to 10.999999~
#range(1,11)[randi()%range(1,11).size()] is a little ugly and less efficient but returns an int from 1 to 10 without you having to do the math yourself (aka the 11+1 part) because all you need to do is set the range()

func _ready():
	print ("initial velocity:" + str(ball.linear_velocity))

# set_applied_force??	
func _integrate_forces(state):
	
	if (!ball_has_been_hit):
		ball.apply_impulse(ball_english, calcBallMovement())
		print ("hit velocity:" + str(state.linear_velocity))
		globals.hit_distance = str(stepify(abs(state.linear_velocity.distance_to(ball_origin) / globals.distance_conversion), 0.1)) + " '"
		#globals.hit_velocity = convertHitVelocity(state.linear_velocity)
		ball_has_been_hit = true
	else:
		pass
	
func calcBallMovement():
	randomize()
	var random_x_factor = randi()%3+1
	var random_y_factor = randi()%52+1
	
	#get a random hit velocity bonus calmped to max from global settings
	globals.hit_power_max = randi()%globals.hit_power_default + globals.hit_power_bonus
	
	# decide X velocity/direction
	var ball_x = randf()*globals.hit_power_max + 1
	match random_x_factor:
		1:pass #[RIGHT FIELD]
		2:ball_x *= -1 #[LEFT FIELD]
		3:ball_x = 0 #[CENTER FIELD]
		
	# decide Y velocity
	var ball_y = (randf()*globals.hit_power_max + 1) * -1
	match random_y_factor:
		51,52: # two chances out of 52 to be fouled back
			ball_y *= -1
		_:
			pass
	
	var ball_direction = Vector2(ball_x, ball_y)
	#print("Angle:" + str(globals.ball_origin.angle_to_point(ball_direction)))
	return ball_direction

func _on_foul_area_body_entered(body):
	if (!foul_banner.visible && !home_run_banner.visible && body.name == "ball"):
		foul_banner.visible = true
	globals.ball_status = "P"
	if (globals.strikes < 2):globals.strikes +=1
	#yield(get_tree().create_timer(4.0), "timeout")
	#get_tree().change_scene("res://scenes/battingView.tscn")


func _on_home_run_area_body_entered(body):
	if (!foul_banner.visible && !home_run_banner.visible && body.name == "ball"):
		home_run_banner.visible = true
		ball.visible = false
		home_run_distance.text = globals.hit_distance
	#uiCam.make_current()

	#globals.ball_status = "P"
	#get_tree().change_scene("res://scenes/battingView.tscn")



		
# EXPERIMENTAL
#	func _ready():
#    # Create a timer node
#    var timer = Timer.new()
#
#    # Set timer interval
#    timer.set_wait_time(1.0)
#
#    # Set it as repeat
#    timer.set_one_shot(false)
#
#    # Connect its timeout signal to the function you want to repeat
#    timer.connect("timeout", self, "repeat_me")
#
#    # Add to the tree as child of the current node
#    add_child(timer)
#
#    timer.start()
#
#
#func repeat_me():
#    print("Loop")
