extends Node2D
onready var anim = get_node("anim_ball_in_play/ball_in_play")

func _process(delta):
	if Input.is_action_just_released("toggle_menu") == true:
		get_tree().change_scene("res://scenes/mainMenu.tscn")
	
	if globals.ball_status == "IP":
		
		# randomize animations based on accuracy of swing
		anim.playback_speed = hit_speed()
		# anim.position = Vector2(100,100) Does not work 
		anim.play(hit_animation())
		globals.ball_status = "P" # resetting ball position to pitcher after line drive (will be changed)
	else:
		pass

func hit_speed():
	var random_speed = randf()*3+1 # random speed between 1 and 3
	return random_speed

func hit_animation():
	var anim_matrix = ["line_drive","line_drive", "pop_fly", "foul_ball"] 
	var rand = randi()%3 + 1
	globals.ball_location.x = 100
	globals.ball_location.y = 100
	
	return anim_matrix[rand]
	