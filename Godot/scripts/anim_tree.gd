extends AnimationTree
var playback : AnimationNodeStateMachinePlayback


func _ready():
	playback = get("parameters/playback")
	playback.start("hit")
	
