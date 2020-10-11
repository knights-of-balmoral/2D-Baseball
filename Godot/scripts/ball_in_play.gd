extends KinematicBody2D

onready var fielder_1 = get_node("../../defense/fielder_1")
onready var fielder_2 = get_node("../../defense/fielder_2")
onready var fielder_3 = get_node("../../defense/fielder_3")
onready var fielder_4 = get_node("../../defense/fielder_4")
onready var fielder_5 = get_node("../../defense/fielder_5")
onready var fielder_6 = get_node("../../defense/fielder_6")
onready var fielder_7 = get_node("../../defense/fielder_7")
onready var fielder_8 = get_node("../../defense/fielder_8")
onready var fielder_9 = get_node("../../defense/fielder_9")
var ball_thrown = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _physics_process(delta):
	if Input.is_action_pressed("throw_1") && globals.ball_status == "FIELDER":
		ball_thrown = true

		# THROW THE BALL TO WHO [player vector- enemy vector]	
#	if (ball_thrown):
#		var throw_target = self.position - fielder_1.position
#		print ("throw ball")
#		ball.visible = true
#		ball.apply_impulse(ball_english, throw_target)
#		ball_thrown = false
