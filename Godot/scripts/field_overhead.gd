extends Node2D
onready var ball_state = get_node("field/ball/anim_tree")
onready var runner = get_node("offense/basepath/runners_path")
onready var foul_banner = get_node("field/ui_canvas/ui/foul")
onready var home_run_banner = get_node("field/ui_canvas/ui/home_run")
onready var foul_area = $field/spray_chart/center_field_area
onready var ball = $field/ball
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

var throw_source = fielder_1 #default to pitcher
var throw_target = fielder_2 #default to catcher

#get_tree().call_group("my_group","my_function",args...)
#If you need to do something with your group:
#
#for member in get_tree().get_nodes_in_group("my_group"):
#    member.my_function(args...)

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	globals.hit_power_max = globals.hit_power_default # rest hit bonus/penalty
	globals.ball_status = "IP"
	ball_state.active = true # turns on auto-advancing animation tree for hits
	foul_banner.visible = false
	home_run_banner.visible = false
	foul_area.monitoring = true
	
	
	
func _unhandled_input(event):
	if Input.is_action_just_pressed("throw_1") && globals.ball_status.left(1) == "F":
		throw_ball()
		
func throw_ball():
	throw_source = select_throw_source()
	throw_target = select_throw_target()
	var new_ball = load("res://scenes/instanced/ball.tscn")
	ball = new_ball.instance()
	$field.add_child(ball)
	ball.global_position = throw_source.global_position
	
	ball.apply_central_impulse(Vector2(100,100))
	#enable_colliders()
	
	globals.ball_status = "IP"

func enable_colliders():
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
	
func select_throw_target():
	pass


func _process(delta):
	set_camera_position()	
		# Toggle Menu 
	if Input.is_action_just_released("toggle_menu") == true:
		globals.ball_status = "P"
		get_tree().change_scene("res://scenes/battingView.tscn")
	
	runner.set_offset(runner.get_offset() + 250 * delta) # .22  - first base, .49 - second base, .73 - third base, 1 - home plate
		
func set_camera_position():
	
	match globals.ball_status:
		"IP":
			cam.global_position = ball.global_position	
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
