extends Node2D
onready var anim = get_node("anim_ball_in_play/ball_in_play")

func _ready():
	globals.bg_fans.volume_db = -20 # turn up the volume slightly on hit (-20 is higher than -30db)
	
func _process(delta):
	
	# See if players presses menu key
	if Input.is_action_just_released("toggle_menu") == true:
		get_tree().change_scene("res://scenes/mainMenu.tscn")
	
	# If the ball is hit
	if globals.ball_status == "IP":
		anim.playback_speed = hit_strength()
		var hitDirection = hit_direction()
			
		# randomize animations based on accuracy of swing
		
		# anim.position = Vector2(100,100) Does not work 
		anim.play(hit_animation())
		globals.ball_status = "P" # resetting ball position to pitcher after line drive (will be changed)
		yield(get_tree().create_timer(2.0), "timeout") # temporary timer to return us to batting view
		get_tree().change_scene("res://scenes/battingView.tscn")
	else:
		pass



func hit_strength():
	var random_speed = randf()*2+1 # random speed between 1 and 3
	return random_speed
	
func hit_direction():
	# function assumes ball is contacted as the overhead field view is displayed
	# This rules out balls/strikes from this function (need to account for foul balls)
	var pitchComputation = pitch_computation()
	
	var hitComputation = ""
	
	return hitComputation #will return a caclulation for direction based on pitch/swing

# These two functions might be better suited moved to the pitcher/batter scenes?
func pitch_computation():
	pass

func hit_animation():
	var anim_matrix = ["line_drive","line_drive", "pop_fly", "foul_ball"] 
	var rand = randi()%3 + 1
	globals.ball_location.x = 100
	globals.ball_location.y = 100
	
	return anim_matrix[rand]
	