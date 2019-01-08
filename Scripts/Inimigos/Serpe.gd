extends "Abstratos/Perseguidor.gd"

const OLHANDO_ESQUERDA	= Vector2(-1, 1)
const OLHANDO_DIREITA	= Vector2(1, 1)


func persegue(delta):
	.persegue(delta)
	
	if (angulo > 0):
		set_scale(OLHANDO_ESQUERDA)
	else:
		set_scale(OLHANDO_DIREITA)



func direcao():
	.direcao()
	
	if (dir == Global.VETOR_ESQUERDA):
		set_scale(OLHANDO_ESQUERDA)
	if (dir == Global.VETOR_DIREITA):
		set_scale(OLHANDO_DIREITA)



func _ready():
	._ready()
	
	movimentacao = Global.MOVIMENTACAO_LENTA

