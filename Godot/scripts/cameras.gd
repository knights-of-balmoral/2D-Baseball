extends Node2D
onready var cam = $"main-camera"
onready var tcam = $"tween-camera"

# NEED TO FIGURE OUT HOW TO TARGET THESE
#onready var fielder_1 = get_node("defense/fielder_1")
#onready var fielder_2 = get_node("defense/fielder_2")
#onready var fielder_3 = get_node("defense/fielder_3")
#onready var fielder_4 = get_node("defense/fielder_4")
#onready var fielder_5 = get_node("defense/fielder_5")
#onready var fielder_6 = get_node("defense/fielder_6")
#onready var fielder_7 = get_node("defense/fielder_7")
#onready var fielder_8 = get_node("defense/fielder_8")
#onready var fielder_9 = get_node("defense/fielder_9")
#onready var ball = get_node("field/ball")

func _ready():
	cam.make_current()

func _process(delta):
	pass
	# if our camera needs to be moved
#	if !globals.camera_is_set:
#		match globals.ball_status:
#			"F1":
#				cam.global_position = fielder_1.global_position
#			"F2":
#				cam.global_position = fielder_2.global_position
#			"F3":
#				cam.global_position = fielder_3.global_position
#			"F4":
#				cam.global_position = fielder_4.global_position
#			"F5":
#				cam.global_position = fielder_5.global_position
#			"F6":
#				cam.global_position = fielder_6.global_position
#			"F7":
#				cam.global_position = fielder_7.global_position
#			"F8":
#				cam.global_position = fielder_8.global_position
#			"F9":
#				cam.global_position = fielder_9.global_position
#			"IP":
#				cam.global_position = ball.global_position	
#			_:
#				pass
		
		# tell the game our camera is in the right spot now		
		#globals.camera_is_set = !globals.camera_is_set
