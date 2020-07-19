extends Button

func _on_ui_play_button_pressed():
	get_tree().change_scene('res://scenes/battingView.tscn')

func _on_ui_options_button_pressed():
	get_tree().change_scene('res://scenes/options.tscn')
	
func _on_ui_quit_button_pressed():
	get_tree().quit()	

func _on_ui_button_hover():
	$Label.modulate = globals.hover_color

func _on_ui_button_unhover():
	$Label.modulate = globals.button_color




