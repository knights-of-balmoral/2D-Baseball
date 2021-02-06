# KNOWN BUGS
# Fielders do not animation(run) when entering the field

extends Node2D
onready var cam = $cutscene_cam
onready var anim = $anim
onready var fielders = get_tree().get_nodes_in_group("fielders")

func _ready():
	cam.make_current()
	for fielder in fielders:
		fielder.player_id.visible = false	
	anim.play("take_the_field")

func _process(delta):
	
	if Input.is_action_just_released("toggle_menu") == true:
		globals._state.ball_status = "P"
		get_tree().change_scene("res://scenes/battingView.tscn")
	

