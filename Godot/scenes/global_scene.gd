extends Node

func _ready():
	pass # Replace with function body.

func _process(delta):
# Toggle Menu 
	if Input.is_action_just_released("toggle_menu") == true:
		globals.ball_status = "P"
		get_tree().change_scene("res://scenes/mainMenu.tscn")
