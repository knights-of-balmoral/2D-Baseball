extends Node2D
onready var home_team_home = get_node("tabs/Home/home_team_card/scoreboard/team_home")
onready var home_team_visitor = get_node("tabs/Home/home_team_card/scoreboard/team_visitor")
onready var visitor_team_home = get_node("tabs/Visitor/visitor_team_card/scoreboard/team_home")
onready var visitor_team_visitor = get_node("tabs/Visitor/visitor_team_card/scoreboard/team_visitor")
onready var h_date = get_node("tabs/Home/home_team_card/date")
onready var v_date = get_node("tabs/Visitor/visitor_team_card/date")


func _ready():
	pass


func _on_tabs_tab_changed(tab):
	home_team_home.text = globals.teams[0]
	home_team_visitor.text = globals.teams[1]
	visitor_team_home.text = globals.teams[0]
	visitor_team_visitor.text = globals.teams[1]
	h_date.text = globals.game_date
	v_date.text = globals.game_date
	
