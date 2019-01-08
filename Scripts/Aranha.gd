extends KinematicBody2D

const MOTION_SPEED = 100
var acum = 0
var dir = Vector2()
var parado = true


func _fixed_process(delta):
	acum += delta
	if (acum >= 1):
		acum -= 1
		if (parado):
			parado = false
			direcao()
		else:
			parado = true
			dir = Vector2()
	
	var motion = dir.normalized()*MOTION_SPEED*delta
	
	motion = move(motion)
	
	var slide_attempts = 4
	while(is_colliding() and slide_attempts > 0):
		motion = get_collision_normal().slide(motion)
		motion = move(motion)
		slide_attempts -= 1


func direcao():
	var aux = 0
	dir = Vector2()
	
	aux = randi() % 4
	
	if (aux == 1):
		dir += Vector2(0, -1)
		set_rot(deg2rad(0))
	if (aux == 2):
		dir += Vector2(0, 1)
		set_rot(deg2rad(180))
	if (aux == 3):
		dir += Vector2(-1, 0)
		set_rot(deg2rad(90))
	if (aux == 0):
		dir += Vector2(1, 0)
		set_rot(deg2rad(270))



func _ready():
	set_fixed_process(true)
	
	randomize()

