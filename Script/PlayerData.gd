extends Node

const max_items = 5
var inventory: Array = []

func _ready() -> void:
	print("PlayerData loaded")

func get_items() -> Array[int]:
	return inventory;

func add_item (item):
	if (inventory.size() < max_items):
		inventory.append(item)
	else:
		print("Full Inventory")

#Remove item in passed index
func remove_item (item):
	var item_index = inventory.find(item)
	if (item_index != -1):
		inventory.remove_at(item_index)
	else:
		print("Error: Item not found in inventory")
