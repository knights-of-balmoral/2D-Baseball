extends CanvasLayer


func _ready():
	pass # Replace with function body.

# Decdies if we got a hit or not
func _process(delta):
	if $ball.pitched == true && $batter.bat_state == "swing":
		get_tree().change_scene('res://scenes/field_overhead.tscn')
