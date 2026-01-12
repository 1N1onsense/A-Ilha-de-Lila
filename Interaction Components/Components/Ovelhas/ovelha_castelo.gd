extends StaticBody2D
@onready var interactable: Area2D = $Interactable
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
var madeira = preload("res://Resources/Items/Wood.tres")


const lines_inicial: Array[String] = [
	"O obstáculo é desafiador, eu não minto. A madeira está no final desse labirinto",
	"Perdida? Não fique rancorosa! Olhe o ambiente para uma dica valiosa!"
]

const lines_final: Array[String] = [
	"Sábia peixinha, você foi muito esperta.",
	"Não foi pelo óbvio e se manteve alerta.",
	"Para esse truque você estava preparada.",
	"Agora temos a madeira para nossa jangada!"
]

func _ready() -> void:
	animated_sprite_2d.play("dormindo")
	interactable.interact = _on_interact
	DialogManager.dialog_finished.connect(_on_dialog_finished)

func _on_interact():
	animated_sprite_2d.play("acordado")
	
	if PlayerData.search_item(madeira) != -1:
		DialogManager.start_dialog(global_position, lines_final)
		return
	DialogManager.start_dialog(global_position, lines_inicial)

func _on_dialog_finished():
	animated_sprite_2d.play("dormindo")
