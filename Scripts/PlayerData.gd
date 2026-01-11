extends Node

signal invetory_has_changed
const max_items = 5
var inventory: Array [ItemData] = []

func _ready() -> void:
	print("PlayerData loaded")

func get_items() -> Array[ItemData]:
	return inventory;

func add_item (item):
	if (inventory.size() < max_items):
		inventory.append(item)
		invetory_has_changed.emit()
	else:
		print("Full Inventory")

#Remove item in passed index
func remove_item (item):
	var item_index = inventory.find(item)
	if (item_index != -1):
		inventory.remove_at(item_index)
		invetory_has_changed.emit()
	else:
		print("Error: Item not found in inventory")
