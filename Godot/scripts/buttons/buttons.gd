extends Button
onready var sound_1 = get_node("../btn_exhibition/AudioStreamPlayer")
onready var sound_2 = get_node("../btn_season/AudioStreamPlayer2")
onready var sound_3 = get_node("../btn_teams/AudioStreamPlayer3")
onready var sound_4 = get_node("../btn_settings/AudioStreamPlayer4")
onready var sound_7 = get_node("../btn_scorecard/AudioStreamPlayer7")

# BUTTON ACTIONS
func _on_btn_exhibition_pressed():
	get_tree().change_scene('res://scenes/battingView.tscn')

func _on_btn_scorecard_pressed():
	get_tree().change_scene('res://scenes/scorecard_tool.tscn')

func _on_btn_settings_pressed():
	get_tree().change_scene('res://scenes/settings.tscn')
	
func _on_btn_quit_pressed():
	get_tree().quit()	

func _on_btn_batting_practice_pressed():
	get_tree().change_scene('res://scenes/battingView.tscn')

# BUTTON SOUNDS
func _on_btn_exhibition_mouse_entered():
	sound_1.play() 
		
func _on_btn_season_mouse_entered():
	sound_2.play()
	
func _on_btn_teams_mouse_entered():
	sound_3.play()
	
func _on_btn_batting_practice_mouse_entered():
	sound_4.play()


func _on_btn_scorecard_mouse_entered():
	sound_7.play()

	
func _on_btn_settings_mouse_entered():
	sound_3.play()
	
func _on_btn_quit_mouse_entered():
	sound_4.play()



