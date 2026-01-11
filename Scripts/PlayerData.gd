extends Node

signal invetory_has_changed
const max_items = 5
var inventory: Array [ItemData] = []
var removed_world_items := []

func _ready() -> void:
	print("PlayerData loaded")

func get_items() -> Array[ItemData]:
	return inventory;

func add_item (item: ItemData):
	if (inventory.size() < max_items):
		inventory.append(item)
		invetory_has_changed.emit()
		#Garante que o item não seja criado novamente
		#Bad coding, mas o jogo eh muito simples para outro Autoload
		removed_world_items.append(item)
	else:
		print("Full Inventory")

func search_item (item: ItemData) -> int:
	return inventory.find(item)
	
func search_removed_item (item: ItemData) -> bool:
	if removed_world_items.find(item) == -1:
		return false
	return true

#Remove item in passed index
func remove_item (item: ItemData):
	var item_index = search_item (item)
	if (item_index != -1):
		inventory.remove_at(item_index)
		invetory_has_changed.emit()
	else:
		print("Error: Item not found in inventory")
