extends KinematicBody2D

#onready var fielder_1 = get_node("../../defense/fielder_1")
#onready var fielder_2 = get_node("../../defense/fielder_2")
#onready var fielder_3 = get_node("../../defense/fielder_3")
#onready var fielder_4 = get_node("../../defense/fielder_4")
#onready var fielder_5 = get_node("../../defense/fielder_5")
#onready var fielder_6 = get_node("../../defense/fielder_6")
#onready var fielder_7 = get_node("../../defense/fielder_7")
#onready var fielder_8 = get_node("../../defense/fielder_8")
#onready var fielder_9 = get_node("../../defense/fielder_9")
var ball_thrown = false

# default throw velocity
const THROW_VELOCITY = 10 # later to be multiplied by normal of vector direction we want ot throw in

# distance per second ball will move
var velocity = Vector2.ZERO


func _ready():
	set_physics_process(false)
	
func _physics_process(delta):
	velocity.y += 1 * delta
	var collision = move_and_collide(velocity * delta)
	if collision != null:
		_on_impact(collision.normal)
	
	
	if Input.is_action_pressed("throw_1") && globals.ball_status == "FIELDER":
		ball_thrown = true

		# THROW THE BALL TO WHO [player vector- enemy vector]	
#	if (ball_thrown):
#		var throw_target = self.position - fielder_1.position
#		print ("throw ball")
#		ball.visible = true
#		ball.apply_impulse(ball_english, throw_target)
#		ball_thrown = false
func throw(direction):
	var temp = global_transform
	var scene = get_tree().current_scene
	get_parent().remove_child(self)
	scene.add_child(self)
	global_transform = temp
	velocity = THROW_VELOCITY * Vector2(direction, 1)
	set_physics_process(true)

func _on_impact(normal : Vector2):
	velocity = velocity.bounce(normal)
	velocity *= 0.5 + rand_range(-0.05, 0.05)
	
