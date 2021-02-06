extends Node

var _state = { 
	"ball_status": "P",
	"balls": 0,
	"strikes": 0,
	"outs": 0,
	"inning": 1,
	"inning_marker": 1,
	"v_team_name": "Badgers",
	"h_team_name": "Knights",
	"v_score": 0,
	"h_score": 0,
	"team_at_bat": "V",
	"v_pitch_count": 0,
	"h_pitch_count":-1
}

var _settings = {
	"ANIM_SPEED" : 10,
	"BALL_ENGLISH_LIMIT" : 20,
	"CURVE_FORCE_LIMIT" : 10,
	"HIT_POWER_DEFAULT" : 2000,
	"hit_power_max" : 0,
	"HIT_POWER_BONUS" : 1000,
	"HIT_POWER_PENALTY" : -3000,
	"HIT_DISTANCE_CONVERSION" : 6.5,
	"hit_distance" : "0 '",
	"ambience_vol" : -7,
	"music_vol" : -7
}

var camera_is_set = false
var pitch_target = "fastball_target_1" #["PTL", "PTC", "PTR", "PLC", "PC", "PRC", "PBL", "PBC", "PBR"]
var pitch_potential_result = "S" #Use for pitch algorithm to return maybe S (strike) or B (ball) W (wild) H (HBP)
var pitch_strength = 1 # speed of animation
var swing_target = "idle" #["W - for Waiting", STL", "STC", "STR", "SLC", "SC", "SRC", "SBL","SBC", "SBR"]
var swing_window_min = 0.5 # first point during pitch a hit is possible
var swing_window_max = 0.9 # last point during pitch a hit is possible
var hit_location = 0 #range from 0 - 110 to decide hit's location (0-10 foul left/back), (100,110 foul rightback)
var ball_origin = Vector2(-25,-9)

# Theme
var hover_color = Color(150, 150, 10, 0.8)
var button_color = Color(1, 1, 1, 1)

# Scorecard Tool
var home_lineup = [[8, "CF", "Happ"], [12, "LF", "Schwarber"], [22, "RF", "Heyward"], 
[40, "C", "Contreras"], [44, "1B", "Rizzo"], [9, "SS", "Baez"], 
[13, "3B", "Bote"], [1, "2B", "Hoerner"], [24, "DH", "Caratini"], ]

var visitor_lineup = [[1, "CF", "Happ"], [2, "LF", "Schwarber"], [3, "RF", "Heyward"], 
[4, "C", "Contreras"], [5, "1B", "Rizzo"], [6, "SS", "Baez"], 
[7, "3B", "Bote"], [8, "2B", "Hoerner"], [9, "DH", "Caratini"], ]

var teams = ["",""]
var game_date = ""
