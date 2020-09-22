extends Control
onready var team = get_parent().name
onready var game_date = get_node("date")
onready var team_name = get_node("team_name")
onready var home_team = get_node("scoreboard/team_home")
onready var visitor_team = get_node("scoreboard/team_visitor")
onready var at_bat_result = get_node("at_bat/at_bat_field/result_selection")
onready var fielder_ref = get_node("at_bat/ui_ref/fielder_ref")
onready var batting_order = $"batting_order"

func _ready():
	add_options()
	load_rosters()

func add_options():
	at_bat_result.add_item("At-Bat")
	at_bat_result.add_item("OUT")
	at_bat_result.add_item("HR")
	at_bat_result.add_item("3B")
	at_bat_result.add_item("2B")
	at_bat_result.add_item("1B")
	at_bat_result.add_item("SH")
	at_bat_result.add_item("BB")
	at_bat_result.add_item("HP")
	at_bat_result.add_item("K")
	at_bat_result.add_item("KL")

func load_rosters():
	match team:
		"Home":
			for i in range(1, globals.home_lineup.size() + 1):
				var current_batter = get_node("batting_order/batter_" + str(i))
				var set_jersey = current_batter.get_node("jersey_no")
				var set_position = current_batter.get_node("player_position")
				var set_name = current_batter.get_node("player_name")
				
				set_jersey.text = str(globals.home_lineup[i-1][0])
				set_position.text = globals.home_lineup[i-1][1]
				set_name.text = globals.home_lineup[i-1][2]
			
		"Visitor":
			for i in range(1, globals.visitor_lineup.size() + 1):
				var current_batter = get_node("batting_order/batter_" + str(i))
				var set_jersey = current_batter.get_node("jersey_no")
				var set_position = current_batter.get_node("player_position")
				var set_name = current_batter.get_node("player_name")
				
				set_jersey.text = str(globals.visitor_lineup[i-1][0])
				set_position.text = globals.visitor_lineup[i-1][1]
				set_name.text = globals.visitor_lineup[i-1][2]


func _on_team_name_text_changed(new_text):
	match team:
		"Home":
			globals.teams[0] = team_name.text
			home_team.text = globals.teams[0]
		"Visitor":
			globals.teams[1] = team_name.text
			visitor_team.text = globals.teams[1]


func _on_tog_fielder_ref_toggled(button_pressed):
	if fielder_ref.visible:
		fielder_ref.visible = false
	else:
		fielder_ref.visible = true


func _on_date_text_changed(new_text):
	globals.game_date = game_date.text


