extends RigidBody2D

# ====================== get nodes
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
#onready var bv = get_node("/root/battingView")
#onready var trail = $ball_trail
var fouls_enabled = true
var curve_force = Vector2(0,0)
var ball_has_been_hit = false
var ball_has_been_thrown = false
var ball_english = Vector2(0, 0) # selects "origin" - like where cue ball is hit (english)
var ball_origin = Vector2(544, 300)
var direction
var fielder_who_has_ball = fielder_1 #default if none have triggered this
#var ball_trail = []

func _ready():
	anim.playback_speed = globals._settings.ANIM_SPEED
	

func _integrate_forces(state):
	if !ball_has_been_hit && globals._state.ball_status == "H":
		hit_ball(state)

func hit_ball(state):
	randomize()
	ball_english = Vector2(rand_range(globals._settings.BALL_ENGLISH_LIMIT * -1, globals._settings.BALL_ENGLISH_LIMIT), 0)
	curve_force = Vector2(rand_range(globals._settings.CURVE_FORCE_LIMIT * -1, globals._settings.CURVE_FORCE_LIMIT), 0)
	ball.apply_impulse(Vector2(), get_hit_trajectory())
	add_force(curve_force, ball_english)
	globals._settings.hit_distance = str(stepify(abs(state.linear_velocity.distance_to(ball_origin) / globals._settings.HIT_DISTANCE_CONVERSION), 0.1)) + " '"
	ball_has_been_hit = true

func update_count(state):
	match state:
		"fair_ball":
			globals._state.strikes = 0
			globals._state.balls = 0
	
func get_hit_trajectory():
	randomize()
	var random_x_factor = randi()%3+1
	var random_y_factor = randi()%52+1

	#get a random hit velocity bonus clamped to max from global settings
	globals._settings.HIT_POWER_MAX = randi()%globals._settings.HIT_POWER_DEFAULT + globals._settings.HIT_POWER_BONUS
	
	# decide X velocity/direction
	var ball_x = randf()*globals._settings.HIT_POWER_MAX + 1
	match random_x_factor:
		1:pass #[RIGHT FIELD]
		2:ball_x *= -1 #[LEFT FIELD]
		3:ball_x = 0 #[CENTER FIELD]
		
	# decide Y velocity
	var ball_y = (randf()*globals._settings.HIT_POWER_MAX + 1) * -1
	match random_y_factor:
		51,52: # two chances out of 52 to be fouled back
			ball_y *= -1
		_:
			pass
	
	var ball_direction = Vector2(ball_x, ball_y)
	#print("Angle:" + str(globals.ball_origin.angle_to_point(ball_direction)))
	return ball_direction
	
func _on_foul_area_body_entered(body):
	if fouls_enabled:
		if (body.name == "ball" && !foul_banner.visible && !home_run_banner.visible && globals._state.ball_status != "F" ):
			foul_banner.visible = true
			globals._state.ball_status = "FOUL"
			if globals._state.strikes <= 1: # avoid strike if it's third for foul balls
				globals._state.strikes +=1
		
		
func _on_home_run_area_body_entered(body):
	print ("HR area entered")
	if (body.name == "ball" && !foul_banner.visible && !home_run_banner.visible && globals._state.ball_status != "F"):
		home_run_banner.visible = true
		globals._state.ball_status = "HR"
		update_score()
		#ball.visible = false
		home_run_distance.text = globals._settings.hit_distance
		_exit_tree()
		
func _on_ball_body_entered(body):
	if "fielder" in body.name && globals._state.ball_status == "CA":
		reassign_fielder(body.name)
		#bv.update_outs()
		_exit_tree()
		print ("out")
		return
		
		
	 # handle normal ball transfer
	if "fielder" in body.name && globals._state.ball_status.left(1) != "F": 
		for pad in dpad:
			pad.visible = true
		globals.camera_is_set = !globals.camera_is_set	
		reassign_fielder(body.name)
		_exit_tree()
		
func _exit_tree():
	self.queue_free()
	
func reassign_fielder(fielder):
	match fielder:
			"fielder_1":
				fielder_who_has_ball =  fielder_1
				fielder_1.reselect_fielders(1)
				globals._state.ball_status = "F1"	
				
			"fielder_2":
				fielder_who_has_ball =  fielder_2
				fielder_1.reselect_fielders(2)
				globals._state.ball_status = "F2"		
				
			"fielder_3":
				fielder_who_has_ball =  fielder_3
				fielder_1.reselect_fielders(3)
				globals._state.ball_status = "F3"		
				
			"fielder_4":
				fielder_who_has_ball =  fielder_4
				fielder_1.reselect_fielders(4)
				globals._state.ball_status = "F4"		
				
			"fielder_5":
				fielder_who_has_ball =  fielder_5
				fielder_1.reselect_fielders(5)
				globals._state.ball_status = "F5"		
				
			"fielder_6":
				fielder_who_has_ball =  fielder_6
				fielder_1.reselect_fielders(6)
				globals._state.ball_status = "F6"		
				
			"fielder_7":
				fielder_who_has_ball =  fielder_7
				fielder_1.reselect_fielders(7)
				globals._state.ball_status = "F7"		
				
			"fielder_8":
				fielder_who_has_ball =  fielder_8
				fielder_1.reselect_fielders(8)
				globals._state.ball_status = "F8"		
				
			"fielder_9":
				fielder_who_has_ball =  fielder_9
				fielder_1.reselect_fielders(9)
				globals._state.ball_status = "F9"
				
			_:
				pass	
	
func _on_right_field_area_body_entered(body):
	pass#foul_area.disabled = true # ball was hit to right field
	#print ("Ball hit to right")
func _on_left_field_area_body_entered(body):
	pass#foul_area.disabled = true # ball was hit to left field
	#print ("Ball hit to left")
func _on_center_field_area_body_entered(body):
	pass#foul_area.disabled = true # ball was hit to center field
	#print ("Ball hit to center")
func update_score():
	# handle home run ball
	if globals._state.team_at_bat == "V":
		globals._state.v_score += 1
	elif globals._state.team_at_bat == "H":
		globals._state.h_score += 1

func _on_fair_territory_line_body_entered(body):
	if body.name == "ball":
		disable_foul()
		update_count("fair_ball")

func disable_foul():
	fouls_enabled = false
	
func enable_foul():
	fouls_enabled = true
