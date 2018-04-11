
extends Node2D

# Member variables
const MAX_POINTS = 10
const INITIAL_BALL_SPEED = 150
const MIN_SPEED = 200
const MAX_SPEED = 500
var ball_speed = INITIAL_BALL_SPEED
var screen_size = Vector2(640, 400)
var pad_size = Vector2(8, 32)
var half_x = 320
var half_y = 200
var left_speed = MIN_SPEED
var right_speed = MIN_SPEED
var left_point = 0
var right_point = 0
var direction


func _process(delta):
	# Get ball position and pad rectangles
	var ball_pos = get_node("Ball").get_pos()
	var left_rect = Rect2(get_node("Left").get_pos() - pad_size * 0.5, pad_size)
	var right_rect = Rect2(get_node("Right").get_pos() - pad_size * 0.5, pad_size)
	
	# Integrate new ball postion
	ball_pos += direction * ball_speed * delta
	
	# Flip when touching roof or floor
	if ((ball_pos.y < -half_y and direction.y < 0) or (ball_pos.y > half_y  and direction.y > 0)):
		direction.y = -direction.y
	
	# Flip, change direction and increase speed when touching pads
	if ((left_rect.has_point(ball_pos) and direction.x < 0) or (right_rect.has_point(ball_pos) and direction.x > 0)):
		ball_speed *= (randf() * 0.5 + 0.8)
		direction.x = -direction.x
		direction.y = randf() * 2.0 - 1
		direction = direction.normalized()
	
	# Check gameover
	if (ball_pos.x < -half_x or ball_pos.x > half_x):
		if (ball_pos.x < -half_x):
			right_point += 1
			get_node("Right_points").set_text(str(right_point))
			direction = Vector2(1, 0)
			ball_pos = Vector2(0, right_rect.pos.y + pad_size.y * 0.5)
		else:
			left_point += 1
			get_node("Left_points").set_text(str(left_point))
			direction = Vector2(-1, 0)
			ball_pos = Vector2(0, left_rect.pos.y + pad_size.y * 0.5)
		
		ball_speed = INITIAL_BALL_SPEED
	
	get_node("Ball").set_pos(ball_pos)
	
	if (left_point >= MAX_POINTS):
		get_node("Resultado").set_text("Ciano ganhou!!")
		get_node("Reiniciar").set_text("Reiniciar")
		get_node("Resultado").show()
		get_node("Reiniciar").show()
		get_node("Fundo_resultado").show()
		set_process(false)
	if (right_point >= MAX_POINTS):
		get_node("Resultado").set_text("Rosa ganhou!!")
		get_node("Reiniciar").set_text("Reiniciar")
		get_node("Resultado").show()
		get_node("Reiniciar").show()
		get_node("Fundo_resultado").show()
		set_process(false)
	
	# Move left pad
	var left_pos = get_node("Left").get_pos()
	
	if (left_pos.y > -half_y and Input.is_action_pressed("left_move_up")):
		left_pos.y += -left_speed*delta
	if (left_pos.y < half_y and Input.is_action_pressed("left_move_down")):
		left_pos.y += left_speed*delta
	
	if (Input.is_action_pressed("left_move_up") or Input.is_action_pressed("left_move_down")):
		if (left_speed < MAX_SPEED):
			left_speed += 1
	else:
		left_speed = MIN_SPEED
	
	get_node("Left").set_pos(left_pos)
	
	# Move right pad
	var right_pos = get_node("Right").get_pos()
	
	if (right_pos.y > -half_y and Input.is_action_pressed("right_move_up")):
		right_pos.y += -right_speed*delta
	if (right_pos.y < half_y and Input.is_action_pressed("right_move_down")):
		right_pos.y += right_speed*delta
	
	if (Input.is_action_pressed("right_move_up") or Input.is_action_pressed("right_move_down")):
		if (right_speed < MAX_SPEED):
			right_speed += 1
	else:
		right_speed = MIN_SPEED
	
	get_node("Right").set_pos(right_pos)


func _ready():
	screen_size = get_viewport_rect().size # Get actual size
	half_x = screen_size.x * 0.5
	half_y = screen_size.y * 0.5
	pad_size = get_node("Left").get_texture().get_size()
	get_node("Resultado").hide()
	get_node("Fundo_resultado").hide()


func _on_Reiniciar_pressed():
	if (randf() > 0.5):
		direction = Vector2(1, 0)
	else:
		direction = Vector2(-1, 0)
	
	left_point = 0
	right_point = 0
	get_node("Ball").set_pos(Vector2(0, 0))
	get_node("Left").set_pos(Vector2(-280, 0))
	get_node("Right").set_pos(Vector2(280, 0))
	get_node("Resultado").hide()
	get_node("Reiniciar").hide()
	get_node("Fundo_resultado").hide()
	get_node("Left_points").set_text(str(left_point))
	get_node("Right_points").set_text(str(right_point))
	set_process(true)
