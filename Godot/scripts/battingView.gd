extends Node2D



func _process(delta):
	if Input.is_action_just_released("toggle_menu") == true:
		get_tree().change_scene("res://scenes/mainMenu.tscn")
		
# Decides if we got a hit or not
	if globals.ball_status == "Pitched" && globals.swing_location != "idle":
		globals.ball_status = "IP" #yields a hit every swing right now
		get_tree().change_scene('res://scenes/field_overhead.tscn')