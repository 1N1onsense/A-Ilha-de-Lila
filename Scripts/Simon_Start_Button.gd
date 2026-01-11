extends StaticBody2D

signal was_interacted
@export var button_id: int
@onready var interactable: Area2D = $Interactable
const WIN_ICECREAM = preload("res://sprites/Objetos/IceCreamGreen.png")
var actual_difficulty = 0
var interact_name_backup: String
#Animated Sprites
@onready var animated_sprite_1: AnimatedSprite2D = $Animation/AnimatedSprite1
@onready var animated_sprite_2: AnimatedSprite2D = $Animation/AnimatedSprite2
@onready var animated_sprite_3: AnimatedSprite2D = $Animation/AnimatedSprite3
var animated_sprites: Array[AnimatedSprite2D]
#Sprites
@onready var sprite_1: Sprite2D = $Sprites/Sprite1
@onready var sprite_2: Sprite2D = $Sprites/Sprite2
@onready var sprite_3: Sprite2D = $Sprites/Sprite3
var sprites: Array[Sprite2D]

func _ready() -> void:
	animated_sprites = [animated_sprite_1, animated_sprite_2, animated_sprite_3]
	sprites = [sprite_1, sprite_2, sprite_3]
	interactable.interact = _on_interact
	for animated_sprite in animated_sprites:
		animated_sprite.self_modulate.a = 0
		animated_sprite.play("efeito")
	interact_name_backup = interactable.interact_name
	if GameManager.simon_completed:
		_disable_button()

func _on_interact():
	if (interactable.is_interactable):
		_disable_button()
		add_anim()
		emit_signal("was_interacted")

func add_anim():
	animated_sprites[actual_difficulty].self_modulate.a = 0.7

func remove_anim():
	animated_sprites[actual_difficulty].self_modulate.a = 0
	
func _enable_button():
	interactable.interact_name = interact_name_backup
	interactable.is_interactable = true

func _disable_button():
	interactable.interact_name = ""
	interactable.is_interactable = false

func _level_win ():
	print("you_win")
	sprites[actual_difficulty].texture = WIN_ICECREAM
	if actual_difficulty == 2:
		_disable_button()
	else:
		actual_difficulty += 1
		add_anim()

func _level_lose ():
	remove_anim()
	_enable_button()
