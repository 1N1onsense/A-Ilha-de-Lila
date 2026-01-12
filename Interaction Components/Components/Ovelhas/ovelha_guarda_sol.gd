extends StaticBody2D
@onready var interactable: Area2D = $Interactable
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@export var concha_dourada : ItemData
@export var item_recompensa: ItemData

var ja_interagiu_primeira_vez = false
var ja_entregou_concha = false

const lines_inicial: Array[String] = [
	"Oi peixinha! Estou aqui pra te ver!",
	"Pois disse que sempre estaria com você",
	"Eu prometi e sempre cumpro promessa dada",
	"Sua próxima missão? Achar a concha dourada!",
	"Desculpe pela bagunça... Eu espero que não se importe...",
	"Eu confio em você, pequenina! Foque na missão e boa sorte!"
]

const lines_com_concha: Array[String] = [
	"Lila, minha peixinha! Você é fenomenal!",
	"Achou a concha rápido naquela bagunça brutal!",
	"Aqui vem a mágica, abra a mochila e vá olhar....",
	"Não tem mais concha, agora é uma corda pra amarrar!" 
]

const lines_sem_concha: Array[String] = [
	"Quem arrumou esse lugar? Pra organização não liga?",
	"Mas de onde danado que está essa concha da bexiga?"
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
