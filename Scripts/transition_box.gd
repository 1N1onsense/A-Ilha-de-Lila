extends Node

@export_file("*.tscn") var next_scene: String
@export var transition_name: String = ""

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		GameManager.actual_transition = transition_name
		get_tree().call_deferred("change_scene_to_file", next_scene)
