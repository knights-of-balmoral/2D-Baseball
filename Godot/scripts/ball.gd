extends RigidBody2D
onready var anim = get_node("anim")
onready var ball = get_node("../ball")
onready var foul_banner = get_node("../ui_canvas/ui/foul")
onready var home_run_banner = get_node("../ui_canvas/ui/home_run")
onready var home_run_distance = get_node("../ui_canvas/ui/home_run/distance")
onready var first_base = get_node("../triggers/base_1")
onready var foul_area = get_node("../spray_chart/foul_area/foul")
onready var fielder_1 = get_node("../../defense/fielder_1")
onready var fielder_2 = get_node("../../defense/fielder_2")
onready var fielder_3 = get_node("../../defense/fielder_3")
onready var fielder_4 = get_node("../../defense/fielder_4")
onready var fielder_5 = get_node("../../defense/fielder_5")
onready var fielder_6 = get_node("../../defense/fielder_6")
onready var fielder_7 = get_node("../../defense/fielder_7")
onready var fielder_8 = get_node("../../defense/fielder_8")
onready var fielder_9 = get_node("../../defense/fielder_9")
onready var dpad = get_tree().get_nodes_in_group("dpad")

var ANIM_SPEED = 10
var THROW_SPEED = 100
var BALL_ENGLISH_LIMIT = 20
var curve_force = Vector2(0,0)
var CURVE_FORCE_LIMIT = 10
#var BALL_HELD_OFFSET = Vector2(0, -60)
var ball_has_been_hit = false
var ball_has_been_thrown = false
#var ball_has_been_thrown = false
var ball_english = Vector2(0, 0) # selects "origin" - like where cue ball is hit (english)
var ball_origin = Vector2(544, 300)
#var throw_target: Vector2
var direction
var fielder_who_has_ball = fielder_1 #default if none have triggered this
var ball_trail = []
onready var trail = $ball_trail

func _ready():
	anim.playback_speed = ANIM_SPEED

func _integrate_forces(state):
	if !ball_has_been_hit && globals.ball_status == "H":
		hit_ball(state)
		randomize()
		ball_english = Vector2(rand_range(BALL_ENGLISH_LIMIT * -1, BALL_ENGLISH_LIMIT), 0)
		curve_force = Vector2(rand_range(CURVE_FORCE_LIMIT * -1, CURVE_FORCE_LIMIT), 0)
		add_force(curve_force, ball_english)

func hit_ball(state):
	randomize()
	ball.apply_impulse(Vector2(), get_hit_trajectory())
	globals.hit_distance = str(stepify(abs(state.linear_velocity.distance_to(ball_origin) / globals.distance_conversion), 0.1)) + " '"
	ball_has_been_hit = true
	
func get_hit_trajectory():
	randomize()
	var random_x_factor = randi()%3+1
	var random_y_factor = randi()%52+1

	#get a random hit velocity bonus clamped to max from global settings
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
	if (body.name == "ball" && !foul_banner.visible && !home_run_banner.visible && globals.ball_status != "F" ):
		foul_banner.visible = true
	globals.ball_status = "FOUL"
	if (globals.strikes < 2):globals.strikes +=1
func _on_home_run_area_body_entered(body):
	if (body.name == "ball" && !foul_banner.visible && !home_run_banner.visible && globals.ball_status != "F"):
		home_run_banner.visible = true
		globals.ball_status = "HR"
		#ball.visible = false
		home_run_distance.text = globals.hit_distance
func _on_ball_body_entered(body):
	 # if a fielder already has the ball, don't run this
	if "fielder" in body.name && globals.ball_status.left(1) != "F": 
		for pad in dpad:
			pad.visible = true
		globals.camera_is_set = !globals.camera_is_set		
		match body.name:
			"fielder_1":
				fielder_who_has_ball =  fielder_1
				fielder_1.reselect_fielders(1)
				globals.ball_status = "F1"	
				
			"fielder_2":
				fielder_who_has_ball =  fielder_2
				fielder_1.reselect_fielders(2)
				globals.ball_status = "F2"		
				
			"fielder_3":
				fielder_who_has_ball =  fielder_3
				fielder_1.reselect_fielders(3)
				globals.ball_status = "F3"		
				
			"fielder_4":
				fielder_who_has_ball =  fielder_4
				fielder_1.reselect_fielders(4)
				globals.ball_status = "F4"		
				
			"fielder_5":
				fielder_who_has_ball =  fielder_5
				fielder_1.reselect_fielders(5)
				globals.ball_status = "F5"		
				
			"fielder_6":
				fielder_who_has_ball =  fielder_6
				fielder_1.reselect_fielders(6)
				globals.ball_status = "F6"		
				
			"fielder_7":
				fielder_who_has_ball =  fielder_7
				fielder_1.reselect_fielders(7)
				globals.ball_status = "F7"		
				
			"fielder_8":
				fielder_who_has_ball =  fielder_8
				fielder_1.reselect_fielders(8)
				globals.ball_status = "F8"		
				
			"fielder_9":
				fielder_who_has_ball =  fielder_9
				fielder_1.reselect_fielders(9)
				globals.ball_status = "F9"
				
			_:
				pass
		_exit_tree()
func _exit_tree():
	#remove_child(self) needs a look - might have to move some code around to prevent mem leaks
	self.queue_free()
func _on_right_field_area_body_entered(body):
	pass#foul_area.disabled = true # ball was hit to right field
	#print ("Ball hit to right")
func _on_left_field_area_body_entered(body):
	pass#foul_area.disabled = true # ball was hit to left field
	#print ("Ball hit to left")
func _on_center_field_area_body_entered(body):
	pass#foul_area.disabled = true # ball was hit to center field
	#print ("Ball hit to center")
