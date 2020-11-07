extends RigidBody2D

onready var anim = get_node("anim")
onready var ball = get_node("../ball")
onready var foul_banner = get_node("../ui_canvas/ui/foul")
onready var home_run_banner = get_node("../ui_canvas/ui/home_run")
onready var home_run_distance = get_node("../ui_canvas/ui/home_run/distance")

var speed = globals.ball_speed
var ball_has_been_hit = false
var ball_english = Vector2(0, 0) # selects "origin" - like where cue ball is hit (english)
var ball_origin = Vector2(544, 300)
var ball_thrown = false


func _ready():
	pass

	
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
	if (body.name == "ball" && !foul_banner.visible && !home_run_banner.visible && globals.ball_status != "FIELDER" ):
		foul_banner.visible = true
	globals.ball_status = "FOUL"
	if (globals.strikes < 2):globals.strikes +=1

func _on_home_run_area_body_entered(body):
	if (body.name == "ball" && !foul_banner.visible && !home_run_banner.visible && globals.ball_status != "FIELDER"):
		home_run_banner.visible = true
		globals.ball_status = "HOMERUN"
		#ball.visible = false
		home_run_distance.text = globals.hit_distance

