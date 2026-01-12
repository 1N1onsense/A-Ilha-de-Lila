extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

const lines: Array[String] = [
	"Oi! Grande pequena Lila!",
	"Pode ver que os sorvetes aqui estão em fila?",
	"Veja e se lembre da ordem que vão brilhar.",
	"Faça isso três vezes e com uma vela vão te presentear!"
]

const lines_venceu: Array[String] = [
	"Lila, a peixinha gênia!",
	"Estou admirada com sua memória.",
	"Quando crescer, não se esqueça de mim!",
	"Ou pelo menos lembre-se dessa história."
]

func _ready() -> void:
	animated_sprite_2d.play("dormindo")
	interactable.interact = _on_interact
	DialogManager.dialog_finished.connect(_on_dialog_finished)

func _on_interact():
	animated_sprite_2d.play("acordado")
	
	if GameManager.simon_completed:
		DialogManager.start_dialog(global_position, lines_venceu)
		return
	DialogManager.start_dialog(global_position, lines)

func _on_dialog_finished():
	animated_sprite_2d.play("dormindo")
