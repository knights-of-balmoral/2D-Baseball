extends RigidBody2D
var speed = globals.ball_speed
var ball_has_been_hit = false
onready var anim = get_node("anim")
onready var ball = get_node("../ball")
#randi()%10+1 returns an int from 1 to 10
#randf()*10.0+1.0 returns a float from 1.0 to 10.999999~
#rand_range(1,11) returns a float from 1.0 to 10.999999~
#range(1,11)[randi()%range(1,11).size()] is a little ugly and less efficient but returns an int from 1 to 10 without you having to do the math yourself (aka the 11+1 part) because all you need to do is set the range()

func _ready():
	pass
	
func _integrate_forces(state):
	# get ball vector 
	if(ball_has_been_hit):
		pass
	else:	
		set_applied_force(calcBallDirection())
		ball_has_been_hit = true
	
func calcBallDirection():
	randomize()
	var random_x_factor = randi()%2+1
	var random_y_factor = randi()%2+1
	
	# decide X velocity
	var ball_x = randf()*100 + 1
	match random_x_factor:
		1:
			pass
		2: 
			ball_x *= -1
		
	# decide Y velocity
	var ball_y = (randf()*100 + 1) * -1
	match random_y_factor:
		1:
			pass
		2:
			ball_y *= -1

				
	print(ball_x, ball_y) # debug - remove
	
	var ball_direction = Vector2(ball_x, ball_y)
	
	return ball_direction

func calcBallVelocity():
	randomize()
	var num = randf()*1 + 1
	return num

