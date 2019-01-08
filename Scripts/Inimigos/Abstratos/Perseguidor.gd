extends "Inimigo.gd"

const DISTANCIA_MAXIMA = 1000

var perseguindo = false
var angulo = 0.0


func _fixed_process(delta):
	var distancia = 0.0
	acum += delta
	
	if (acum >= 1):
		acum -= 1
		
		if (alvo == null):
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
				dir = Global.VETOR_NULO
	
	if (perseguindo):
		persegue(delta)
		anda(delta)
	else:
		if(not parado):
			anda(delta)



func persegue(delta):
	dir = Global.VETOR_NULO
	
	if (get_pos().distance_to(alvo.get_pos()) > DISTANCIA_MAXIMA):
		perseguindo = false
		parado = true
		return
	
	angulo = get_pos().angle_to_point(alvo.get_pos())
	dir = Vector2(-sin(angulo), -cos(angulo))

