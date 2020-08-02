extends Node
onready var bg_fans = get_node("/root/global_scene/bgStadium")
onready var bg_music = get_node("/root/global_scene/bgMusic")

func _ready():
	get_tree().change_scene("res://scenes/mainMenu.tscn")
	#get_tree().change_scene("res://scenes/field_overhead.tscn")
	bg_fans.volume_db = globals.ambience_volume
	bg_music.volume_db = globals.music_volume
	bg_fans.stop()
	bg_music.stop()
	

