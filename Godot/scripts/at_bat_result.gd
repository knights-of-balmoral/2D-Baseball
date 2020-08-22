extends Node2D
onready var at_bat_result = get_node("result_selection")

func _ready():
	add_options()
	

func add_options():
	at_bat_result.add_item("HR")
	at_bat_result.add_item("3B")
	at_bat_result.add_item("2B")
	at_bat_result.add_item("1B")
	at_bat_result.add_item("SH")
	at_bat_result.add_item("BB")
	at_bat_result.add_item("HP")
	at_bat_result.add_item("K")
	at_bat_result.add_item("KL")
