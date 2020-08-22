extends KinematicBody2D
onready var zoom_cam = get_node("zoom_cam")
onready var pos_label = get_node("positions")

var zoom_level = Vector2(0,0)
var zoom_power = 0.2


func _ready():
	set_process(true)
	set_as_toplevel(true)
	
	
func _process(delta):
	self.position = get_global_mouse_position()
	pos_label.text = "g: " + str(self.position) + "\n z: " + str(zoom_cam.zoom)
		
	if Input.is_action_just_released("zoom_in") == true:
		zoom_level += Vector2((-1 * zoom_power), (-1 * zoom_power))
		zoom_cam.zoom = zoom_level
		
	elif Input.is_action_just_released("zoom_out") == true:
		zoom_level += Vector2(zoom_power, zoom_power)
		zoom_cam.zoom = zoom_level
		
	if (zoom_level < Vector2(0.4, 0.4)):
		zoom_level = Vector2(0.4, 0.4)
	elif (zoom_level > Vector2(3,3)):
		zoom_level = Vector2(3,3)
