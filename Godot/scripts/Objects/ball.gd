extends KinematicBody2D
onready var anim = get_node("anim_ball")
var pitched = false
var ball_state = "pitcher"

func _physics_process(delta): # delta times things with clock/render cycle
	
	# If ball hasn't been pitched, pitch it
	if Input.is_action_pressed("pitch_ball") && pitched == false:
		anim.play("fastball")
		pitched = true
		$console_log.text = str(pitched)
	
	if $anim_ball.current_animation_position == 0.5:
		pitched	= false
		$console_log.text = str(pitched)
	if $anim_ball.current_animation_position == 0.4 && get_node("batter").ball_state == "swing":
		get_tree().change_scene('res://scenes/field_overhead.tscn')
