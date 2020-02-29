extends Node2D
onready var anim = get_node("anim_ball_in_play/ball_in_play")
onready var console = get_node("anim_ball_in_play/test_label")

#IP(In Play) ["1", "P"], ["2", "C"],["3", "1B"],["4", "2B"],["5", "3B"],["6", "SS"],["7", "LF"],["8", "CF"],["9", "RF"]]
var ball_status = "IP" 

func _process(delta):
	if Input.is_action_just_released("toggle_menu") == true:
		get_tree().change_scene("res://scenes/mainMenu.tscn")
	
	
	
	if ball_status == "IP":
		
		# randomize animations based on accuracy of swing
		anim.playback_speed = hit_speed()
		
		anim.play("line_drive")
		ball_status = "P" # resetting ball position to pitcher after line drive (will be changed)
	else:
		pass

func hit_speed():
	var random_speed = randf()*4+1 # random speed between 1 and 3
	console.text = str(random_speed)
	return random_speed