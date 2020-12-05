extends Line2D
var target
var point
export var trail_length = 10
export (NodePath) var target_path

func _ready():
	target = get_node(target_path)

func _process(delta):
	update_ball_trail()

func update_ball_trail():
	var pos = target.global_position
	global_position = Vector2(0,0)
	global_rotation = 0
	add_point(pos)
	
	while get_point_count() > trail_length:
		remove_point(0)
