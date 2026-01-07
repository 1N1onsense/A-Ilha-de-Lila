extends CharacterBody2D

const velocidade = 120
var DirecaoAtual = "none"
func _physics_process(delta: float) -> void:
	movimento(delta)
	move_and_slide()
func movimento(delta):
	if Input.is_action_pressed("ui_right"):
		DirecaoAtual = "direita"
		animacao(1)
		velocity.x = velocidade
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		DirecaoAtual = "esquerda"
		animacao(1)
		velocity.x = -velocidade
		velocity.y = 0
	elif Input.is_action_pressed("ui_up"):
		DirecaoAtual = "cima"
		animacao(1)
		velocity.x = 0
		velocity.y = -velocidade
	elif Input.is_action_pressed("ui_down"):
		DirecaoAtual = "baixo"
		animacao(1)
		velocity.x = 0
		velocity.y = velocidade
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
