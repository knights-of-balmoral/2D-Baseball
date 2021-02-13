extends KinematicBody2D
onready var defender_selected = get_node("defender_selected")
onready var fielders = get_tree().get_nodes_in_group("fielders")
onready var anim = $defender/anim
onready var anim_tree = $defender/AnimationTree
onready var player_id = $player_id
#onready var ball = get_node("../../field/ball")
var MAX_SPEED = 500
var ACCELERATION = 1500
var ANIM_SPEED = 4
var motion = Vector2.ZERO
var defender_is_moving = false

func _ready():
	anim.playback_speed = ANIM_SPEED
	anim.play("idle")
	# show/hide fielder selection circle
	defender_selected.visible = false
	player_id.text = self.name.trim_prefix("fielder_")
	
func _physics_process(delta):
	var axis = get_input_axis()
	

	
	if defender_selected.visible: # only move if selected
		motion = move_and_slide(motion)
#		if globals.game_state.ball_status == "F":
#			ball.set_global_position(self.global_position)
		
		if axis == Vector2.ZERO:
			apply_friction(ACCELERATION * delta)
			# animation here to transition to idle
			$defender/anim.play("idle")
		else: 
			apply_movement(axis * ACCELERATION * delta)
			# animation here for running character
			$defender/anim.play("run_right")
	else:
		$defender/anim.play("idle")
		
func _process(delta):
	select_fielder()
	
func play_anim( animation_name ) -> void:
	anim.play( animation_name )

func stop_anim() -> void:
	anim.stop()

func get_input_axis():
	var axis = Vector2.ZERO
	var previous_position = Vector2(axis.x, axis.y)
	
	axis.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	axis.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	if axis.x != 0 || axis.y != 0:
		defender_is_moving = true
	
	# detect if we're moving left or right
	if previous_position.x < axis.x && defender_selected.visible == true:
		$defender.flip_h = false
	else:
		$defender.flip_h = true
		
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
	
	# Defense Controls - Move to unhandled input?
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



func _on_detection_body_entered(body):
	if body.name == "ball":
		pass
