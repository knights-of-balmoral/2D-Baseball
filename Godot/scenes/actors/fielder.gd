extends KinematicBody2D
onready var defender_selected = get_node("defender_selected")
onready var fielders = get_tree().get_nodes_in_group("fielders")
onready var ball = get_tree().get_nodes_in_group("ball")
onready var ball_effect = $has_ball_effect
onready var foul_area = get_node("../../field/spray_chart/foul_area")

var MAX_SPEED = 400
var ACCELERATION = 2000
var motion = Vector2.ZERO
var fielder_has_ball = false
var throw_power = 100
var ball_thrown = false
var ball_english = Vector2(0,0) # selects "origin" - like where cue ball is hit (english)

func _ready():
	
	# show/hide fielder selection circle
	if defender_selected.visible:
		defender_selected.visible = false 
	else: 
		defender_selected.visible = true
		
	ball_effect.visible = false
	fielder_has_ball = false

func _physics_process(delta):
	var axis = get_input_axis()
	if axis == Vector2.ZERO:
		apply_friction(ACCELERATION) 
	else: 
		apply_movement(axis * ACCELERATION)
		
	if defender_selected.visible: # only move if selected
		motion = move_and_slide(motion)
	
func _process(delta):
	select_fielder()
	
	# if a fielder has the ball, then make ball follow that fielder
	if (ball_effect.visible):
		ball[0].position = self.position #0 index of ball because of how we selected node with get by group

#	move_fielder(fielder_selected)
func get_input_axis():
	var axis = Vector2.ZERO
	axis.x = Input.get_action_strength("defense_move_right") - Input.get_action_strength("defense_move_left")
	axis.y = Input.get_action_strength("defense_move_down") - Input.get_action_strength("defense_move_up")
	return axis.normalized()
func apply_friction(amount):
	if motion.length() > amount:
		motion -= motion.normalized() * amount
	else:
		motion = Vector2.ZERO
		
func apply_movement(acceleration):
	motion += acceleration
	motion = motion.clamped(MAX_SPEED)
func select_fielder():
	
	# Defense Controls
	if Input.is_action_pressed("select_1"):
		reselect_fielders(1)
			
	elif Input.is_action_just_pressed("select_2"):
		reselect_fielders(2)			
			
	elif Input.is_action_just_pressed("select_3"):
		reselect_fielders(3)
			
	elif Input.is_action_just_pressed("select_4"):
		reselect_fielders(4)
			
	elif Input.is_action_just_pressed("select_5"):
		reselect_fielders(5)
			
	elif Input.is_action_just_pressed("select_6"):
		reselect_fielders(6)
			
	elif Input.is_action_just_pressed("select_7"):
		reselect_fielders(7)
			
	elif Input.is_action_just_pressed("select_8"):
		reselect_fielders(8)
			
	elif Input.is_action_just_pressed("select_9"):
		reselect_fielders(9)
			
	elif Input.is_action_just_pressed("closest_fielder"): #KP-ADD is the key
		reselect_fielders(0)
func reselect_fielders(defender):
	if defender > 0:
		for member in fielders:
			if member.name == "fielder_" + str(defender):
				member.get_node("defender_selected").visible = true
			else:
				member.get_node("defender_selected").visible = false
	else: #when input leads to a zero or closest defender
		get_nearest_fielder()
func get_nearest_fielder():
	var nearest = "fielder_1"
	#var distance = null
func _on_detection_body_entered(body):
	 # if a fielder already has the ball, don't run this
	if (body.name == "ball" && !fielder_has_ball && globals.ball_status != "FIELDER"):
		fielder_has_ball = true
		globals.ball_status = "FIELDER"
		ball_effect.visible = true
		#zero of array is because of way node is selected above
		ball[0].visible = false 
		foul_area.monitoring = false
		
		
		
		
		
		
		
