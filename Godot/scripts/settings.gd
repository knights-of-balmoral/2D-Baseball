extends Control
onready var music_volume_status = $g_music_options/lbl_music_volume/lbl_music_volume_value
onready var ambience_volume_status = $g_ambience_volume/lbl_ambience_volume/lbl_ambience_volume_value

onready var bg_fans = get_node("/root/global_scene/bgStadium")
onready var bg_music = get_node("/root/global_scene/bgMusic")

func _on_sldMusicVolume_value_changed(value):
	globals._settings.music_vol = value
	bg_music.volume_db = globals._settings.music_vol # Replace with function body.
	
	if value <= -24:
		music_volume_status.text = "OFF"
		bg_music.stop()
	elif value >= 0:
		music_volume_status.text = "MAX"
	else:
		music_volume_status.text = str(bg_music.volume_db + 100) #convert db to numbers that make sense
		
		if bg_music.playing == false:
			 bg_music.play()

func _process(delta):
	if Input.is_action_just_released("toggle_menu") == true:
		get_tree().change_scene("res://scenes/mainMenu.tscn")
		


func _on_sld_ambience_volume_value_changed(value):
	globals._settings.ambience_vol = value
	bg_fans.volume_db = globals._settings.ambience_vol # Replace with function body.
	
	if value <= -24:
		ambience_volume_status.text = "OFF"
		bg_fans.stop()
	elif value >= 0:
		ambience_volume_status.text = "MAX"
	else:
		ambience_volume_status.text = str(bg_fans.volume_db + 100) #convert db to numbers that make sense
		if bg_fans.playing == false:
			 bg_fans.play()
