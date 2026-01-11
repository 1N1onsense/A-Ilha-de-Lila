extends Node

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Mapas e Cenas/mundo.tscn")
	MusicManager.play()

func _on_exit_pressed() -> void:
	get_tree().quit()
