extends Node

func _ready() -> void:
	MusicManager.stop()

func _on_exit_pressed() -> void:
	get_tree().quit()
