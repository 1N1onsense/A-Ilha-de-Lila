extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D

const lines: Array[String] = [
	"A área dos guarda-sóis está toda bagunçada. Encontre a concha onde nela está a corda para a jangada"
]

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	DialogManager.start_dialog(global_position, lines)
