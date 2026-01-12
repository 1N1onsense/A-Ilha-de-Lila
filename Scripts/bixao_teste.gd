extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var wood = preload("res://Resources/Items/Wood.tres")
var rope = preload("res://Resources/Items/Rope.tres")
var sail = preload("res://Resources/Items/Sail.tres")

var has_wood = PlayerData.search_item(wood) != -1
var has_rope = PlayerData.search_item(rope) != -1
var has_sail = PlayerData.search_item(sail) != -1

var ultima_fala_foi_1 = false

const lines: Array[String] = [
	"Peixinha, peixinha! Você está perdida?",
	"Não fique triste, vou te ajudar minha querida!",
	"Sou sua amiga e nunca irei te abandonar!",
	"Mas para sair daqui... Por alguns perrengues você deve passar...",
	"Eu sei que está ansiosa, mas leia cada placa com atenção",
	"Resolva os desafios e pegue os materias para fazer a construção...",
	"De uma bela jangada, pilar por pilar",
	"E então navegaremos daqui para o mar!",
	"Nosso conto será épico e hilário!",
	"Use 'I' para abrir o seu inventário"
]

const line_1: Array[String] = [
	"Boa Peixinha, no ritmo e no compasso!",
	"Está indo bem, pronta para o próximo passo?"
]

const line_2: Array[String] = [
	"A ilha é bonita e bem relaxante.",
	"Se quiser, aprecie por um instante."
]

func _ready() -> void:
	animated_sprite_2d.play("dormindo")
	interactable.interact = _on_interact
	
	# Conecta ao sinal de fim do diálogo
	DialogManager.dialog_finished.connect(_on_dialog_finished)

func _on_interact():
	animated_sprite_2d.play("acordado")
	
	if has_rope or has_sail or has_wood:
		if ultima_fala_foi_1:
			DialogManager.start_dialog(global_position, line_2)
			ultima_fala_foi_1 = false
		else:
			DialogManager.start_dialog(global_position, line_1)
			ultima_fala_foi_1 = true
	else:
		DialogManager.start_dialog(global_position, lines)

func _on_dialog_finished():
	animated_sprite_2d.play("dormindo")
