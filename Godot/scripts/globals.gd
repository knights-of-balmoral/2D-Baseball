extends Node

var pitch_location = "PC" #["PTL", "PTC", "PTR", "PLC", "PC", "PRC", "PBL", "PBC", "PBR", "S", "B"]
var swing_location = "idle" #["W - for Waiting", STL", "STC", "STR", "SLC", "SC", "SRC", "SBL","SBC", "SBR"]
var hit_location = "" #range from 0 - 110 to decide hit's location (0-10 foul left/back), (100,110 foul rightback)
var ball_status = "P" #IP(In Play) ["1", "P"], ["2", "C"],["3", "1B"],["4", "2B"],["5", "3B"],["6", "SS"],["7", "LF"],["8", "CF"],["9", "RF"]]
var ball_location = Vector2(0,0)
var strikes = 0
var balls = 0
var outs = 0
var inning = 1
var team_at_bat = false # false = Visitor,  true = Home Team