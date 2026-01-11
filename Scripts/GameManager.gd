extends Node

signal toggle_bag_requested
var actual_transition: String = "start_game"
var simon_completed: bool = false

func _process(delta: float) -> void:
	if Input.is_action_just_released("inventario"):
		request_toggle_bag()

func request_toggle_bag():
	emit_signal("toggle_bag_requested")
