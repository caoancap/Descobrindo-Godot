extends KinematicBody2D

var up = false
var down = false

onready var sprite = get_node("Sprite")


func _fixed_process(delta):
	var motion = Global.VETOR_NULO
	
	up = false
	down = false
	
	if (Input.is_action_pressed("ui_up")):
		motion += Global.VETOR_ACIMA
		sprite.set_rot(Global.RAD_000_GRAUS)
		up = true
	
	if (Input.is_action_pressed("ui_down")):
		motion += Global.VETOR_ABAIXO
		sprite.set_rot(Global.RAD_180_GRAUS)
		down = true
	
	if (Input.is_action_pressed("ui_left")):
		motion += Global.VETOR_ESQUERDA
		if (not (up and down)):
			sprite.set_rot(Global.RAD_090_GRAUS)
		if (up):
			sprite.set_rot(Global.RAD_045_GRAUS)
		if (down):
			sprite.set_rot(Global.RAD_135_GRAUS)
	
	if (Input.is_action_pressed("ui_right")):
		motion += Global.VETOR_DIREITA
		if (not (up and down)):
			sprite.set_rot(Global.RAD_270_GRAUS)
		if (up):
			sprite.set_rot(Global.RAD_315_GRAUS)
		if (down):
			sprite.set_rot(Global.RAD_225_GRAUS)
	
	motion = motion.normalized() * Global.MOVIMENTACAO_RAPIDA * delta
	motion = move(motion)
	
	# Make character slide nicely through the world
	var slide_attempts = 4
	while (is_colliding() and slide_attempts > 0):
		motion = get_collision_normal().slide(motion)
		motion = move(motion)
		slide_attempts -= 1


func _ready():
	set_fixed_process(true)
