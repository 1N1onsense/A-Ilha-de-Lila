extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D

const lines: Array[String] = [
	"Dale mano, meu nome é O Bichão Louco!",
	"Alguns me chamam de mono Kha'zix.",
	"Mas isso já faz muito tempo...",
	"Eu já aposentei esse lado meu há muito tempo...",
	"Mas cuidado, esse meu lado ainda habita dentro de mim."
]

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	DialogManager.start_dialog(global_position, lines)
