extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D

const lines: Array[String] = [
	"Avançar é um erro!"
]

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	DialogManager.start_dialog(global_position, lines)
