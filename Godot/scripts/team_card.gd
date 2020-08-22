extends Control
onready var team = get_parent().name
onready var team_name = get_node("team_name")
onready var home_team = get_node("scoreboard/team_home")
onready var visitor_team = get_node("scoreboard/team_visitor")


func _ready():
	pass # Replace with function body.


func _on_team_name_text_changed(new_text):
	match team:
		"Home":
			globals.home_team = team_name.text
			home_team.text = globals.home_team
		"Visitor":
			globals.visitor_team = team_name.text
			visitor_team.text = globals.visitor_team
