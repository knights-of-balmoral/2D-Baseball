extends Camera2D

func _ready():
	set_process(true)
	set_as_toplevel(true)
	global_position = get_global_mouse_position()
	
func _process(delta):
	self.position = get_global_mouse_position()

