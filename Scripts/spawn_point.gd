extends Node2D

@export var transition_name: String = ""
@export var face_direction: String = ""

func _ready():
	if GameManager.actual_transition == transition_name:
		var player = get_tree().get_first_node_in_group("player")
		if player:
			player.global_position = global_position
			player.set_face_direction(face_direction)
		else:
			print ("Error: Player not Found for SpawnPoint")
