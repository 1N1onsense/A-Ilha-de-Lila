extends StaticBody2D
@onready var interactable: Area2D = $Interactable
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var concha_dourada : ItemData
@export var item_recompensa: ItemData

var ja_interagiu_primeira_vez = false
var ja_entregou_concha = false

const lines_inicial: Array[String] = [
	"Olá de novo, pequena peixinha, eu disse que estaria com você sempre",
	"Eu sempre cumpro o que prometo, Lila",
	"Agora, sua missão aqui é achar uma Concha Dourada",
	"Eu sei que o ambiente ao seu redor está uma bagunça, mas não esqueça o que realmente importa",
	"Se você focar no que peço, te darei tudo o que você precisa"
]

const lines_com_concha: Array[String] = [
	"Que rápido, você já encontrou a Concha Dourada",
	"Muito bem, Lila. Você está indo pelo caminho certo",
	"Se você reparar a sua bolsa, eu transformei a Concha em uma Corda"
]

const lines_sem_concha: Array[String] = [
	"Você ainda não encontrou a Concha Dourada",
	"Continue procurando, pequena peixinha"
]

func _ready() -> void:
	animated_sprite_2d.play("dormindo")
	interactable.interact = _on_interact
	DialogManager.dialog_finished.connect(_on_dialog_finished)

func _on_interact():
	animated_sprite_2d.play("acordado")
	
	# Se ainda não interagiu
	if !ja_interagiu_primeira_vez:
		DialogManager.start_dialog(global_position, lines_inicial)
		ja_interagiu_primeira_vez = true
	# Se já está com a concha
	elif !ja_entregou_concha and PlayerData.search_item(concha_dourada) != -1:
		DialogManager.start_dialog(global_position, lines_com_concha)
		PlayerData.remove_item(concha_dourada)
		PlayerData.add_item(item_recompensa)
		ja_entregou_concha = true
	# Já interagiu e tá sem concha
	elif !ja_entregou_concha:
		DialogManager.start_dialog(global_position, lines_sem_concha)
	# Já entregou a concha
	else:
		DialogManager.start_dialog(global_position, ["Estou aqui para salvar você, Lila."])

func _on_dialog_finished():
	animated_sprite_2d.play("dormindo")
