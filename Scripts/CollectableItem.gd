extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D
@export var item_data: ItemData

func _ready() -> void:
	if PlayerData.search_removed_item(item_data):
		queue_free()
	else:
		interactable.interact = _on_interact

func _on_interact():
	PlayerData.add_item(item_data)
	queue_free()
