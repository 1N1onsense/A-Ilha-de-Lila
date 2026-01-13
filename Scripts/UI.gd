extends Control

@onready var panel = $"CanvasLayer/MarginContainer/HBoxContainer/Background Margin/Background"
@onready var bag = $"CanvasLayer/MarginContainer/HBoxContainer/Bag"
@onready var items_ui =$"CanvasLayer/MarginContainer/HBoxContainer/Background Margin/Background/Items Margin/Items"
const ITEM_FRAME = preload("res://Mapas e Cenas/ItemFrame.tscn")
var inventory_is_open: bool = false

func _ready():
	panel.modulate.a = 0
	GameManager.toggle_bag_requested.connect(toggle_inventory)
	PlayerData.invetory_has_changed.connect(att_inventory)
	PlayerData.invetory_has_changed.connect(animate_inventory)
	att_inventory()

func att_inventory():
	var inventory = PlayerData.get_items()
	if (inventory.is_empty()):
		var empty_item = load("res://Resources/Items/EmptyItem.tres")
		refresh_ui([empty_item])
	else:
		refresh_ui(inventory)


func animate_inventory():
	if !inventory_is_open:
		toggle_inventory()
		await get_tree().create_timer(1.5).timeout
		toggle_inventory()

func refresh_ui(inventory : Array[ItemData]):
	for child in items_ui.get_children():
		child.queue_free()
	for item_data in inventory:
		var item_frame = ITEM_FRAME.instantiate()
		items_ui.add_child(item_frame)
		item_frame.texture = item_data.img

func toggle_inventory():
	var tween = create_tween()
	
	if !inventory_is_open:
		# Desliza para a direita e aparece
		tween.tween_property(panel, "modulate:a", 1.0, 0.3)
	else:
		# Desliza para a esquerda e some
		tween.tween_property(panel, "modulate:a", 0.0, 0.2)
	inventory_is_open = !inventory_is_open
	
