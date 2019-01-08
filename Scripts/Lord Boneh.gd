extends KinematicBody2D

# This is a simple collision demo showing how
# the kinematic controller works.
# move() will allow to move the node, and will
# always move it to a non-colliding spot, 
# as long as it starts from a non-colliding spot too.

# Member variables
const MOTION_SPEED = 150 # Pixels/seconds

var up = false
var down = false


func _fixed_process(delta):
	var motion = Vector2()
	
	up = false
	down = false
	
	if (Input.is_action_pressed("ui_up")):
		motion += Vector2(0, -1)
		set_rot(deg2rad(0))
		up = true
	
	if (Input.is_action_pressed("ui_down")):
		motion += Vector2(0, 1)
		set_rot(deg2rad(180))
		down = true
	
	if (Input.is_action_pressed("ui_left")):
		motion += Vector2(-1, 0)
		if(not(up and down)):
			set_rot(deg2rad(90))
		if(up):
			set_rot(deg2rad(45))
		if(down):
			set_rot(deg2rad(135))
	
	if (Input.is_action_pressed("ui_right")):
		motion += Vector2(1, 0)
		if(not(up and down)):
			set_rot(deg2rad(270))
		if(up):
			set_rot(deg2rad(315))
		if(down):
			set_rot(deg2rad(225))
	
	motion = motion.normalized()*MOTION_SPEED*delta
	motion = move(motion)
	
	# Make character slide nicely through the world
	var slide_attempts = 4
	while(is_colliding() and slide_attempts > 0):
		motion = get_collision_normal().slide(motion)
		motion = move(motion)
		slide_attempts -= 1


func _ready():
	set_fixed_process(true)
