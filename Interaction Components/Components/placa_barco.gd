extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var sprite_2d: Sprite2D = $Sprite2D

const lines: Array[String] = [
	"Praia plana e acessível, ideal para construir barcos e apreciar sua beleza incrível"
]

func _ready() -> void:
	interactable.interact = _on_interact

func _on_interact():
	const wood = preload("res://Resources/Items/Wood.tres")
	const sail = preload("res://Resources/Items/Sail.tres")
	const rope = preload("res://Resources/Items/Rope.tres")
	
	var has_wood = PlayerData.search_item(wood) != -1
	var has_sail = PlayerData.search_item(sail) != -1
	var has_rope = PlayerData.search_item(rope) != -1
	
	if 	has_wood and has_sail and has_rope:
		get_tree().call_deferred("change_scene_to_file", "res://Mapas e Cenas/TelaFinal.tscn")
		return
	else:
		DialogManager.start_dialog(global_position, lines)
