extends Node


const RAD_000_GRAUS = deg2rad(0)
const RAD_045_GRAUS = deg2rad(45)
const RAD_090_GRAUS = deg2rad(90)
const RAD_135_GRAUS = deg2rad(135)
const RAD_180_GRAUS = deg2rad(180)
const RAD_225_GRAUS = deg2rad(225)
const RAD_270_GRAUS = deg2rad(270)
const RAD_315_GRAUS = deg2rad(315)

const MOVIMENTACAO_LENTA = 200
const MOVIMENTACAO_NORMAL = 600
const MOVIMENTACAO_RAPIDA = 600

const VETOR_ACIMA = Vector2(0, -1)
const VETOR_ABAIXO = Vector2(0, 1)
const VETOR_ESQUERDA = Vector2(-1, 0)
const VETOR_DIREITA = Vector2(1, 0)
const VETOR_NULO = Vector2(0, 0)

onready var listaReservados = {}

func _ready():
	randomize()

func addReservado(res, nome):
	listaReservados[nome] = res



func buscaReservado(nome):
	return listaReservados[nome]



func removeReservado(nome):
	listaReservados.erase(nome)



func direcaoAleatoria():
	var aux = randi() % 4
	
	if (aux == 1):
		return VETOR_ACIMA
	if (aux == 2):
		return VETOR_ABAIXO
	if (aux == 3):
		return VETOR_ESQUERDA
	if (aux == 0):
		return VETOR_DIREITA
	
	return VETOR_NULO