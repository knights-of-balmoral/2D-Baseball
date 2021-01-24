extends Node
onready var bg_fans = get_node("/root/global_scene/bgStadium")
onready var bg_music = get_node("/root/global_scene/bgMusic")

# Load custom images for the mouse
onready var arrow = load("res://assets/raw/gui/cursor.png")
#onready var beam = load("res://assets/raw/gui/beam.png")

#var max = OS.get_screen_size()
#OS.set_window_size(max)
#OS.set_window_position(Vector2(0,0))
#
#or OS.set_window_fullscreen(true)
#OS.set_borderless_window(true)

func _ready():
	get_tree().change_scene("res://scenes/mainMenu.tscn")
	#get_tree().change_scene("res://scenes/field_overhead.tscn")
	bg_fans.volume_db = globals.ambience_volume
	bg_music.volume_db = globals.music_volume
	bg_fans.stop()
	#bg_music.stop()
	bg_music.play()
	# Changes only the arrow shape of the cursor.
	# This is similar to changing it in the project settings.
	Input.set_custom_mouse_cursor(arrow)
	# Changes a specific shape of the cursor (here, the I-beam shape).
	#Input.set_custom_mouse_cursor(beam, Input.CURSOR_IBEAM)

func _process(delta):
	#if Input.is_action_just_pressed("")
	pass
