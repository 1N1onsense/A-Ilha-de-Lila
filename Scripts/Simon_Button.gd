extends StaticBody2D

signal was_interacted
@export var button_id: int
@onready var interactable: Area2D = $Interactable
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sound: AudioStreamPlayer2D = $AudioStreamPlayer2D
var interact_name_backup: String = ""

func _ready() -> void:
	interactable.interact = _on_interact
	animated_sprite_2d.self_modulate.a = 0
	animated_sprite_2d.play("efeito")
	interact_name_backup = interactable.interact_name
	if !GameManager.simon_completed:
		_disable_button()

func _on_interact():
	if (interactable.is_interactable):
		animate_button("interaction")
		emit_signal("was_interacted", button_id)

func animate_button(type = "string"):
	if type == "interaction":
		animated_sprite_2d.self_modulate.a = 0.7
		sound.play()
		await get_tree().create_timer(0.5).timeout
		animated_sprite_2d.self_modulate.a = 0
	elif type == "animation":
		animated_sprite_2d.self_modulate.a = 0.7
		sound.play()
		await get_tree().create_timer(1).timeout
		animated_sprite_2d.self_modulate.a = 0

func _enable_button():
	interactable.interact_name = interact_name_backup
	interactable.is_interactable = true

func _disable_button():
	interactable.interact_name = ""
	interactable.is_interactable = false
