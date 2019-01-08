extends "Abstratos/Inimigo.gd"


func direcao():
	.direcao()
	
	if (dir == Global.VETOR_ACIMA):
		set_rot(Global.RAD_000_GRAUS)
	if (dir == Global.VETOR_ABAIXO):
		set_rot(Global.RAD_180_GRAUS)
	if (dir == Global.VETOR_ESQUERDA):
		set_rot(Global.RAD_180_GRAUS)
	if (dir == Global.VETOR_DIREITA):
		set_rot(Global.RAD_270_GRAUS)

