extends Node2D
onready var anim = get_node("field/ball/anim")
onready var ball_state = get_node("field/ball/anim_tree")
onready var ball = get_node("field/ball")
var ball_vector = Vector2(10, -200)

##var num = randf()*1 + 1 # Y will most likely be always subtracted unless it's a foul ball straight back


func _ready():
	
	# get ball velocity
	ball_state.active = true
	


func _process(delta):
	pass
	



	


