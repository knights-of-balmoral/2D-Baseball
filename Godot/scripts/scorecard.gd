extends Control
var mouse_position
onready var camera = get_node("zoom_cam")

func _ready():
	pass # Replace with function body.
	
func _input(event):
	mouse_position = event.global_position()
	camera.position = mouse_position
