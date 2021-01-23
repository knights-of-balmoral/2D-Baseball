extends Node2D
onready var ball_state = get_node("field/ball/anim_tree")
onready var runner = get_node("offense/basepath/runners_path")
onready var foul_banner = get_node("field/ui_canvas/ui/foul")
onready var home_run_banner = get_node("field/ui_canvas/ui/home_run")
onready var foul_area = $field/spray_chart/center_field_area
onready var ball = $field/ball
onready var anim = $field/ball/anim
onready var cam = $"cam-main"
onready var fielder_1 = $defense/fielder_1
onready var fielder_2 = $defense/fielder_2
onready var fielder_3 = $defense/fielder_3
onready var fielder_4 = $defense/fielder_4
onready var fielder_5 = $defense/fielder_5
onready var fielder_6 = $defense/fielder_6
onready var fielder_7 = $defense/fielder_7
onready var fielder_8 = $defense/fielder_8
onready var fielder_9 = $defense/fielder_9
onready var fielder_1_collision = $defense/fielder_1/CollisionShape2D
onready var fielder_2_collision = $defense/fielder_2/CollisionShape2D
onready var fielder_3_collision = $defense/fielder_3/CollisionShape2D
onready var fielder_4_collision = $defense/fielder_4/CollisionShape2D
onready var fielder_5_collision = $defense/fielder_5/CollisionShape2D
onready var fielder_6_collision = $defense/fielder_6/CollisionShape2D
onready var fielder_7_collision = $defense/fielder_7/CollisionShape2D
onready var fielder_8_collision = $defense/fielder_8/CollisionShape2D
onready var fielder_9_collision = $defense/fielder_9/CollisionShape2D
onready var dpad = get_tree().get_nodes_in_group("dpad")
var throw_source = fielder_1 #default to pitcher
var throw_target = fielder_2 #default to catcher
export var DEFAULT_THROW_STRENGTH = 2000
var camera_is_set = false




#get_tree().call_group("my_group","my_function",args...)
#If you need to do something with your group:
#
#for member in get_tree().get_nodes_in_group("my_group"):
#    member.my_function(args...)

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	globals.hit_power_max = globals.hit_power_default # rest hit bonus/penalty
	ball_state.active = true # turns on auto-advancing animation tree for hits
	foul_banner.visible = false
	home_run_banner.visible = false
	foul_area.monitoring = true
	for pad in dpad:
		pad.visible = false
	
	
func _process(delta):
	#if !camera_is_set:
	set_camera_position()	
		# Toggle Menu 
	if Input.is_action_just_released("toggle_menu") == true:
		globals.ball_status = "P"
		get_tree().change_scene("res://scenes/battingView.tscn")
	
	# if the ball is outside of a fielder's AO, turn the fielder collisions back on
	# But what if the fielders are very close together - problems would ensue
	#if globals.ball_status == "IP":
	#	enable_colliders()
	
	runner.set_offset(runner.get_offset() + 450 * delta) # .22  - first base, .49 - second base, .73 - third base, 1 - home plate
		
		
func _unhandled_input(event):
	if globals.ball_status.left(1) == "F":
		if Input.is_action_just_pressed("throw_1"):
			throw_target = fielder_3 # First Baseman
			throw_ball()
		elif Input.is_action_just_pressed("throw_2"):
			throw_target = fielder_4 # Second Baseman
			throw_ball()
		elif Input.is_action_just_pressed("throw_3"):
			throw_target = fielder_5 # Third Baseman
			throw_ball()
		elif Input.is_action_just_pressed("throw_4"):
			throw_target = fielder_2 # Home Plate / Catcher
			throw_ball()	
		elif Input.is_action_just_pressed("throw_p"):
			throw_target = fielder_1 # Pitcher
			throw_ball()
		else:
			pass
	
func throw_ball():
	for pad in dpad:
		pad.visible = false
	var throw_direction = Vector2.ZERO
	camera_is_set = false
	var new_ball = load("res://scenes/instanced/ball.tscn")
	ball = new_ball.instance()
	
	$field.add_child(ball)
	
	throw_source = select_throw_source()
	ball.global_position = throw_source.global_position
	throw_direction = (throw_target.global_position - ball.global_position).normalized()
	
	ball.visible = true
	# throw strength will need a per-player bonus
	ball.apply_impulse(Vector2.ZERO, throw_direction * DEFAULT_THROW_STRENGTH)
	globals.ball_status = "IP"

func enable_colliders():
	yield(get_tree().create_timer(1.0), "timeout")
	fielder_1_collision.set_disabled(false)
	fielder_2_collision.set_disabled(false)
	fielder_3_collision.set_disabled(false)
	fielder_4_collision.set_disabled(false)
	fielder_5_collision.set_disabled(false)
	fielder_6_collision.set_disabled(false)
	fielder_7_collision.set_disabled(false)
	fielder_8_collision.set_disabled(false)
	fielder_9_collision.set_disabled(false)

func select_throw_source():
	
	## ISSUES ##
	# 1. Fielder can disable collider while throwing and escape field
	
	enable_colliders()
	match globals.ball_status:
		"F1":
			fielder_1_collision.set_disabled(true)
			return fielder_1
		"F2":		
			fielder_2_collision.set_disabled(true)
			return fielder_2
		"F3":		
			fielder_3_collision.set_disabled(true)
			return fielder_3
		"F4":		
			fielder_4_collision.set_disabled(true)
			return fielder_4
		"F5":
			fielder_5_collision.set_disabled(true)		
			return fielder_5
		"F6":
			fielder_6_collision.set_disabled(true)		
			return fielder_6
		"F7":		
			fielder_7_collision.set_disabled(true)
			return fielder_7
		"F8":		
			fielder_8_collision.set_disabled(true)
			return fielder_8
		"F9":		
			fielder_9_collision.set_disabled(true)
			return fielder_9
		_:
			pass
			
func set_camera_position():
	camera_is_set = true
	match globals.ball_status:
		"H":
			cam.global_position = ball.global_position
		"IP":
			if $field.has_node("ball"):
				cam.global_position = ball.global_position	
			else:
				camera_is_set = false
		"F1":		
			cam.global_position = fielder_1.global_position
		"F2":		
			cam.global_position = fielder_2.global_position
		"F3":		
			cam.global_position = fielder_3.global_position
		"F4":		
			cam.global_position = fielder_4.global_position
		"F5":		
			cam.global_position = fielder_5.global_position
		"F6":		
			cam.global_position = fielder_6.global_position
		"F7":		
			cam.global_position = fielder_7.global_position
		"F8":		
			cam.global_position = fielder_8.global_position
		"F9":		
			cam.global_position = fielder_9.global_position
		_:
			pass
