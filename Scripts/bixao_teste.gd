extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const lines: Array[String] = [
	"Olá, pequena peixinha, vejo que você parece perdida.",
	"Mas não se preocupe, eu estou aqui para ajudar você.",
	"Na verdade eu sempre estarei com você...",
	"Agora você precisa passar por algumas coisas para sair daqui.",
	"Por favor, leia as placas e tente resolver todos os desafios.",
	"Ao resolver você irá coletar os materiais necessários para construir um barco e sair daqui.",
	"E eu irei no barco com você."
]

func _ready() -> void:
	animated_sprite_2d.play("dormindo")
	interactable.interact = _on_interact
	
	# Conecta ao sinal de fim do diálogo
	DialogManager.dialog_finished.connect(_on_dialog_finished)

func _on_interact():
	animated_sprite_2d.play("acordado")
	DialogManager.start_dialog(global_position, lines)
	#animated_sprite_2d.play("dormindo")
	
func _on_dialog_finished():
	animated_sprite_2d.play("dormindo")
