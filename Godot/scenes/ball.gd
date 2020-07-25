extends RigidBody2D
var speed = globals.ball_speed
var ball_has_been_hit = false
var ball_english = Vector2(0,0) # selects "origin" - like where cue ball is hit (english)
onready var anim = get_node("anim")
onready var ball = get_node("../ball")

#randi()%10+1 returns an int from 1 to 10
#randf()*10.0+1.0 returns a float from 1.0 to 10.999999~
#rand_range(1,11) returns a float from 1.0 to 10.999999~
#range(1,11)[randi()%range(1,11).size()] is a little ugly and less efficient but returns an int from 1 to 10 without you having to do the math yourself (aka the 11+1 part) because all you need to do is set the range()

func _ready():
	print ("initial velocity:" + str(ball.linear_velocity))
# set_applied_force??	
func _integrate_forces(state):
	
	if (!ball_has_been_hit):
		ball.apply_impulse(ball_english, calcBallDirection())
		print ("hit velocity:" + str(state.linear_velocity))
		ball_has_been_hit = true
	else:
		pass#print ("then:" + str(state.linear_velocity))
		

	
func calcBallDirection():
	randomize()
	var random_x_factor = randi()%2+1
	var random_y_factor = randi()%52+1
	
	#get a random hit velocity bonus calmped to max from global settings
	globals.hit_power = randi()%globals.hit_power_max + 1
	
	# decide X velocity
	var ball_x = randf()*globals.hit_power + 1
	match random_x_factor:
		1:
			pass#print("x" + str(random_x_factor))
		2: 
			ball_x *= -1
		
	# decide Y velocity
	var ball_y = (randf()*globals.hit_power + 1) * -1
	match random_y_factor:
		51,52:
			ball_y *= -1
			#print("y" + str(random_y_factor))
		_:
			pass#print("y" + str(random_y_factor))

				
	#print(ball_x, ball_y) # debug - remove
	
	var ball_direction = Vector2(ball_x, ball_y)
	#print("Angle:" + str(globals.ball_origin.angle_to_point(ball_direction)))
	return ball_direction
