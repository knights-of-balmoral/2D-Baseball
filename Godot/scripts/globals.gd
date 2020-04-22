extends Node

var pitch_target = "fastball_target_1" #["PTL", "PTC", "PTR", "PLC", "PC", "PRC", "PBL", "PBC", "PBR"]
var pitch_potential_result = "S" #Use for pitch algorithm to return maybe S (strike) or B (ball) W (wild) H (HBP)
var pitch_strength = 1 # speed of animation
var swing_target = "idle" #["W - for Waiting", STL", "STC", "STR", "SLC", "SC", "SRC", "SBL","SBC", "SBR"]
var swing_window_min = 0.5 # first point during pitch a hit is possible
var swing_window_max = 0.9 # last point during pitch a hit is possible
var hit_location = 0 #range from 0 - 110 to decide hit's location (0-10 foul left/back), (100,110 foul rightback)
var ball_status = "P" #IP(In Play) ["1", "P"], ["2", "C"],["3", "1B"],["4", "2B"],["5", "3B"],["6", "SS"],["7", "LF"],["8", "CF"],["9", "RF"]]
var ball_location = Vector2(0,0)

# smallest x coord we allow the ball to be, etc
var ball_x_min = 170 
var ball_x_max = 970
var ball_y_min = -10
var ball_y_max = 610
var ball_x = 0
var ball_y = 0
var ball_shadow = Vector2(100,100)
var strikes = 0
var balls = 0
var outs = 0
var inning = 1
var team_at_bat = false # false = Visitor,  true = Home Team

# Sound effects
onready var bg_fans = get_node("/root/global_scene/bgStadium")
onready var bg_music = get_node("/root/global_scene/bgMusic")
var ambience_volume = -12
var music_volume = -12

# Theme
var hover_color = Color(150, 150, 10, 0.8)
var button_color = Color(1, 1, 1, 1)