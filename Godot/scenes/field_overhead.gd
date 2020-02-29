extends Node2D
onready var anim = get_node("anim_ball_in_play/ball_in_play")

#IP(In Play) ["1", "P"], ["2", "C"],["3", "1B"],["4", "2B"],["5", "3B"],["6", "SS"],["7", "LF"],["8", "CF"],["9", "RF"]]
var ball_status = "IP"

func _process(delta):
	if Input.is_action_just_released("toggle_menu") == true:
		get_tree().change_scene("res://scenes/mainMenu.tscn")
	
	
	
	if ball_status == "IP":
		
		# randomize animations based on accuracy of swing
		anim.playback_speed = hit_speed()
		
		anim.play(hit_animation())
		ball_status = "P" # resetting ball position to pitcher after line drive (will be changed)
	else:
		pass

func hit_speed():
	var random_speed = randf()*3+1 # random speed between 1 and 3
	return random_speed

func hit_animation():
	var anim_matrix = ["line_drive","line_drive", "pop_fly", "foul_ball"] # change base of array to 1?
	var rand = randi()%3 + 1
	print(rand) # show rand in the console log
	# console.text = str(rand)
	return anim_matrix[rand]
	