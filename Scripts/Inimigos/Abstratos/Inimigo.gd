extends KinematicBody2D

onready var batalha = preload("res://Batalha/Cenas/Batalha.scn")
onready var alvo    = get_tree().get_root().get_node("Mundo/Node2D/Lord Boneh")

var movimentacao = Global.MOVIMENTACAO_NORMAL
var acum         = 0
var burrice      = 1 # Quanto maior mais vezes vai tentar andar contra a parede
var dir          = Global.VETOR_NULO
var parado       = true


func _init():
	pass



func _ready():
	set_fixed_process(true)



func _fixed_process(delta):
	acum += delta
	if (acum >= 1):
		acum -= 1
		if (parado):
			parado = false
			direcao()
		else:
			parado = true
			dir = Global.VETOR_NULO
	
	anda(delta)



func direcao():
	dir = Global.direcaoAleatoria()



func iniciaBatalha():
	var raiz        = get_tree().get_root()
	var mundo       = raiz.get_node("Mundo")
	var novaBatalha = batalha.instance()
	
	mundo.remove_child(self)
	raiz.remove_child(mundo)
	raiz.add_child(novaBatalha)
	
	Global.addReservado(mundo, "Mundo")
	
	self.queue_free()



func anda(delta):
	var motion = dir.normalized() * movimentacao * delta
	
	motion = move(motion)
	
	var slide_attempts = burrice
	while (is_colliding() and slide_attempts > 0):
		if (get_collider() == alvo):
			iniciaBatalha()
		
		motion = get_collision_normal().slide(motion)
		motion = move(motion)
		slide_attempts -= 1