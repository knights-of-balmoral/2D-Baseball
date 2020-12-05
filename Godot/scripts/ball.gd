#mem management (unload nodes no longer being used)
#func _exit_tree():
#	self.queue_free()

extends RigidBody2D
onready var anim = get_node("anim")
onready var ball = get_node("../ball")
onready var foul_banner = get_node("../ui_canvas/ui/foul")
onready var home_run_banner = get_node("../ui_canvas/ui/home_run")
onready var home_run_distance = get_node("../ui_canvas/ui/home_run/distance")
onready var first_base = get_node("../triggers/base_1")
onready var foul_area = get_node("../spray_chart/foul_area/foul")
onready var test = $test
onready var fielder_1 = get_node("../../defense/fielder_1")
onready var fielder_2 = get_node("../../defense/fielder_2")
onready var fielder_3 = get_node("../../defense/fielder_3")
onready var fielder_4 = get_node("../../defense/fielder_4")
onready var fielder_5 = get_node("../../defense/fielder_5")
onready var fielder_6 = get_node("../../defense/fielder_6")
onready var fielder_7 = get_node("../../defense/fielder_7")
onready var fielder_8 = get_node("../../defense/fielder_8")
onready var fielder_9 = get_node("../../defense/fielder_9")

var ANIM_SPEED = 10
var THROW_SPEED = globals.THROW_SPEED
#var BALL_HELD_OFFSET = Vector2(0, -60)
var speed = globals.ball_speed
var ball_has_been_hit = false
var ball_has_been_thrown = false
var ball_english = Vector2(0, 0) # selects "origin" - like where cue ball is hit (english)
var ball_origin = Vector2(544, 300)
var throw_target: Vector2
var direction
var fielder_who_has_ball = fielder_1 #default if none have triggered this
var ball_trail = []
onready var trail = $ball_trail

func _ready():
	anim.playback_speed = ANIM_SPEED

# Use unhandled input virtual method to avoid interfering with in-game menus with _gui_input
func _unhandled_input(event):
	if Input.is_action_just_pressed("throw_1") && globals.ball_status == "F":
		ball_has_been_thrown = true
			
	#self.get_tree().get_root().set_input_as_handled()
	
func _process(delta):
	if globals.ball_status == "F":
		ball_follow_fielder(fielder_who_has_ball)
	
	# test section
	test.text = "S: " + str(globals.ball_status) 

		
func _integrate_forces(state):
	if !ball_has_been_hit:
		hit_ball(state)
	if ball_has_been_thrown:
		throw_ball()

func hit_ball(state):
	ball.apply_impulse(ball_english, get_hit_trajectory())
	globals.hit_distance = str(stepify(abs(state.linear_velocity.distance_to(ball_origin) / globals.distance_conversion), 0.1)) + " '"
	#globals.hit_velocity = convertHitVelocity(state.linear_velocity)
	ball_has_been_hit = !ball_has_been_hit

func throw_ball():
	globals.ball_status = "T"
	self.visible = true
	#self.anim.play("standard_throw")
	throw_target = fielder_2.global_position
	direction = throw_target - fielder_who_has_ball.global_position#first_base.global_position - fielder_who_has_ball.global_position
	direction = direction.normalized()
	#ball.rotate(get_angle_to(throw_target))
	ball.apply_impulse(Vector2(), direction * THROW_SPEED)
	print ("Throw Origin: " + str(self.global_position))
	print ("dir:" + str(direction))
	globals.ball_status = "IP"
	ball_has_been_thrown = !ball_has_been_thrown
	#fielder_who_has_ball.get_child(4).set_deferred("disabled", false)

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
	
func ball_follow_fielder(fielder_to_follow):
	self.set_global_position(fielder_to_follow.global_position)# + BALL_HELD_OFFSET) 
	
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
	if "fielder" in body.name && globals.ball_status != "F":
		globals.ball_status = "F"
		
		#self.visible = false 
		#foul_area.disabled = true
		
		match body.name:
			"fielder_1":
				fielder_who_has_ball =  fielder_1
			"fielder_2":
				fielder_who_has_ball =  fielder_2
			"fielder_3":
				fielder_who_has_ball =  fielder_3
			"fielder_4":
				fielder_who_has_ball =  fielder_4
			"fielder_5":
				fielder_who_has_ball =  fielder_5
			"fielder_6":
				fielder_who_has_ball =  fielder_6
			"fielder_7":
				fielder_who_has_ball =  fielder_7
			"fielder_8":
				fielder_who_has_ball =  fielder_8
			"fielder_9":
				fielder_who_has_ball =  fielder_9
			_:
				pass
				
		#fielder_who_has_ball.get_child(4).set_deferred("disabled", true)

func _on_right_field_area_body_entered(body):
	pass#foul_area.disabled = true # ball was hit to right field
	#print ("Ball hit to right")

func _on_left_field_area_body_entered(body):
	pass#foul_area.disabled = true # ball was hit to left field
	#print ("Ball hit to left")

func _on_center_field_area_body_entered(body):
	pass#foul_area.disabled = true # ball was hit to center field
	#print ("Ball hit to center")
