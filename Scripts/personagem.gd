extends CharacterBody2D
const velocidade = 120
var DirecaoAtual = "none"

func set_face_direction(face_direction: String):
	DirecaoAtual = face_direction
	animacao(0)

func _physics_process(delta: float) -> void:
	movimento(delta)
	move_and_slide()
	
func movimento(delta):
	# Variável para poder trocar de andar -> correr
	var VelocidadeAtual = velocidade
	
	# Se apertar shift aumenta velocidade
	if Input.is_action_pressed("ui_shift"):
		VelocidadeAtual = velocidade * 1.5
		
	var esta_movendo = false # Flag pra saber se tá se movendo
		
	if Input.is_action_pressed("ui_right"):
		DirecaoAtual = "direita"
		esta_movendo = true
		if Input.is_action_pressed("ui_up"):
			velocity.x = VelocidadeAtual
			velocity.y = -VelocidadeAtual
		elif Input.is_action_pressed("ui_down"):
			velocity.x = VelocidadeAtual
			velocity.y = VelocidadeAtual
		else:
			velocity.x = VelocidadeAtual
			velocity.y = 0
				
	elif Input.is_action_pressed("ui_left"):
		DirecaoAtual = "esquerda"
		esta_movendo = true
		if Input.is_action_pressed("ui_up"):
			velocity.x = -VelocidadeAtual
			velocity.y = -VelocidadeAtual
		elif Input.is_action_pressed("ui_down"):
			velocity.x = -VelocidadeAtual
			velocity.y = VelocidadeAtual
		else:
			velocity.x = -VelocidadeAtual
			velocity.y = 0
	elif Input.is_action_pressed("ui_up"):
		DirecaoAtual = "cima"
		esta_movendo = true
		if Input.is_action_pressed("ui_right"):
			velocity.x = VelocidadeAtual
			velocity.y = -VelocidadeAtual
		elif Input.is_action_pressed("ui_left"):
			velocity.x = -VelocidadeAtual
			velocity.y = -VelocidadeAtual
		else:
			velocity.x = 0
			velocity.y = -VelocidadeAtual
	elif Input.is_action_pressed("ui_down"):
		DirecaoAtual = "baixo"
		esta_movendo = true
		if Input.is_action_pressed("ui_right"):
			velocity.x = VelocidadeAtual
			velocity.y = VelocidadeAtual
		elif Input.is_action_pressed("ui_left"):
			velocity.x = -VelocidadeAtual
			velocity.y = VelocidadeAtual
		else:
			velocity.x = 0
			velocity.y = VelocidadeAtual
	if esta_movendo and velocity.length() > 0:
		velocity = velocity.normalized() * VelocidadeAtual
		animacao(1)
	else:
		animacao(0)
		velocity.x = 0
		velocity.y = 0
		
func animacao(mov):
	var direcao = DirecaoAtual
	var anim = $AnimatedSprite2D
	if direcao == "direita":
		if mov == 1:
			anim.play("andar-direita")
		elif mov == 0:
			anim.play("parada-direita")
	elif direcao == "esquerda":
		if mov == 1:
			anim.play("andar-esquerda")
		elif mov == 0:
			anim.play("parada-esquerda")
	elif direcao == "cima":
		if mov == 1:
			anim.play("andar-cima")
		elif mov == 0:
			anim.play("parada-cima")
	elif direcao == "baixo":
		if mov == 1:
			anim.play("andar-baixo")
		elif mov == 0:
			anim.play("parada-baixo")
