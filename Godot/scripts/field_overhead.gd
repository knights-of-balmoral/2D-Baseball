extends Node2D
onready var ball_state = get_node("field/ball/anim_tree")

func _ready():
	
	# turns on auto-advancing animation tree for hits
	ball_state.active = true


func _process(delta):
	# Toggle Menu 
	if Input.is_action_just_released("toggle_menu") == true:
		globals.ball_status = "P"
		get_tree().change_scene("res://scenes/battingView.tscn")
	



	


