extends Control

@onready var panel = $"CanvasLayer/MarginContainer/HBoxContainer/Background Margin/Background"
@onready var bag = $"CanvasLayer/MarginContainer/HBoxContainer/Bag"

var inventory_is_open: bool = false

func _process(delta: float) -> void:
	GameManager.toggle_bag_requested.connect(toggle_inventory)

func _ready():
	panel.modulate.a = 0
	#await get_tree().create_timer(2.0).timeout
	#toggle_inventory ()
	#await get_tree().create_timer(2.0).timeout
	#toggle_inventory ()

func toggle_inventory():
	var tween = create_tween()
	
	if !inventory_is_open:
		# Desliza para a direita e aparece
		tween.tween_property(panel, "modulate:a", 1.0, 0.3)
	else:
		# Desliza para a esquerda e some
		tween.tween_property(panel, "modulate:a", 0.0, 0.2)
	inventory_is_open = !inventory_is_open
	
