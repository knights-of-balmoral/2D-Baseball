extends Node2D
onready var home_team_home = get_node("tabs/Home/home_team_card/scoreboard/team_home")
onready var home_team_visitor = get_node("tabs/Home/home_team_card/scoreboard/team_visitor")
onready var visitor_team_home = get_node("tabs/Visitor/visitor_team_card/scoreboard/team_home")
onready var visitor_team_visitor = get_node("tabs/Visitor/visitor_team_card/scoreboard/team_visitor")


func _ready():
	pass


	


func _on_tabs_tab_changed(tab):
	home_team_home.text = globals.home_team
	home_team_visitor.text = globals.visitor_team
	visitor_team_home.text = globals.home_team
	visitor_team_visitor.text = globals.visitor_team
