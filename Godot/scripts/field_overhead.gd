extends Node2D
onready var ball_state = get_node("field/ball/anim_tree")
onready var runner = get_node("offense/basepath/runners_path")
onready var foul_banner = get_node("field/ui_canvas/ui/foul")
onready var home_run_banner = get_node("field/ui_canvas/ui/home_run")
onready var foul_area = $field/spray_chart/center_field_area


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
	#baserunner tweening (freezes game atm)
#	var tween = Tween.new()
#	add_child(tween)
#	tween.interpolate_property(runner, "unit_offset",
#								0, 1, 6,
#								tween.TRANS_LINEAR,
#								tween.EASE_IN)
#	tween.set_repeat(false)
#	tween.start()


func _process(delta):
	# Toggle Menu 
	if Input.is_action_just_released("toggle_menu") == true:
		globals.ball_status = "P"
		get_tree().change_scene("res://scenes/battingView.tscn")
	
	runner.set_offset(runner.get_offset() + 250 * delta) # .22  - first base, .49 - second base, .73 - third base, 1 - home plate
