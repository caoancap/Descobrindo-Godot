extends KinematicBody2D

const MOTION_SPEED = 50
const DISTANCIA_MAXIMA = 200
var acum = 0
var dir = Vector2()
var parado = true
var perseguindo = false

var begin = Vector2()
var end = Vector2()
var path = []

var alvo
var navi



func _fixed_process(delta):
	var distancia = 0
	acum += delta
	
	if (acum >= 1):
		acum -= 1
		
		if(alvo == null):
			distancia = 500
		else:
			distancia = get_pos().distance_to(alvo.get_pos())
		
		if (distancia <= DISTANCIA_MAXIMA):
			perseguindo = true
			parado = false
		else:
			if (parado):
				parado = false
				direcao()
			else:
				parado = true
				dir = Vector2()
	
	if (perseguindo):
		persegue(delta)
		anda(delta)
	else:
		if(!parado):
			anda(delta)



func anda(delta):
	var motion = dir.normalized()*MOTION_SPEED*delta
	
	motion = move(motion)
	
	var slide_attempts = 4
	while(is_colliding() and slide_attempts > 0):
		motion = get_collision_normal().slide(motion)
		motion = move(motion)
		slide_attempts -= 1



func persegue(delta):
	dir = Vector2()
	
	if (get_pos().distance_to(alvo.get_pos()) > DISTANCIA_MAXIMA):
		perseguindo = false
		parado = true
		return
	
	var a = get_pos().angle_to_point(alvo.get_pos())
	dir = Vector2(-sin(a), -cos(a))



func direcao():
	var aux = 0
	dir = Vector2()
	
	aux = randi() % 4
	
	if (aux == 1):
		dir += Vector2(0, -1)
	if (aux == 2):
		dir += Vector2(0, 1)
	if (aux == 3):
		dir += Vector2(-1, 0)
	if (aux == 0):
		dir += Vector2(1, 0)



func _ready():
	alvo = get_tree().get_root().get_node("Node/Node2D/Lord Boneh")
	navi = get_tree().get_root().get_node("Node/Node2D/Mapa")
	
	set_fixed_process(true)
	
	randomize()

