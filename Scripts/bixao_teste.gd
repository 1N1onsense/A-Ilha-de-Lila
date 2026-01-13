extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var wood = preload("res://Resources/Items/Wood.tres")
var rope = preload("res://Resources/Items/Rope.tres")
var sail = preload("res://Resources/Items/Sail.tres")

var ultima_fala = 0
var fez_tutorial = false

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

const line_1: Array[String] = ["Boa Peixinha, no ritmo e no compasso!", "Está indo bem, pronta para o próximo passo?"]
const line_2: Array[String] = ["A ilha é bonita e bem relaxante", "Se quiser, aprecie por um instante"]
const line_3: Array[String] = ["Eu? Sou sua amiga do coração", "Por isso que sempre ajudei até então"]
const line_4: Array[String] = ["Porque eu falo desse jeito?", "Eu sou uma ovelha de conceito"]
const line_5: Array[String] = ["Se não conseguir de primeira, não desista", "Para cada desafio dessa ilha, há uma pista"]

func _ready() -> void:
	animated_sprite_2d.play("dormindo")
	interactable.interact = _on_interact
	
	# Conecta ao sinal de fim do diálogo
	DialogManager.dialog_finished.connect(_on_dialog_finished)

func _on_interact():
	animated_sprite_2d.play("acordado")
	
	if fez_tutorial:
		match ultima_fala:
			0: DialogManager.start_dialog(global_position, line_1)
			1: DialogManager.start_dialog(global_position, line_2)
			2: DialogManager.start_dialog(global_position, line_3)
			3: DialogManager.start_dialog(global_position, line_4)
			4: DialogManager.start_dialog(global_position, line_5)
		ultima_fala = (ultima_fala + 1) % 5
	else:
		DialogManager.start_dialog(global_position, lines)
		fez_tutorial = true

func _on_dialog_finished():
	animated_sprite_2d.play("dormindo")
