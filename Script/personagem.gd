extends CharacterBody2D

const velocidade = 120
func _physics_process(delta: float) -> void:
	movimento(delta)
	move_and_slide()
func movimento(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = velocidade
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -velocidade
		velocity.y = 0
	elif Input.is_action_pressed("ui_up"):
		velocity.x = 0
		velocity.y = -velocidade
	elif Input.is_action_pressed("ui_down"):
		velocity.x = 0
		velocity.y = velocidade
	else:
		velocity.x = 0
		velocity.y = 0
