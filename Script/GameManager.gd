extends Node

signal toggle_bag_requested

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("inventario"):
		request_toggle_bag()

func request_toggle_bag():
	emit_signal("toggle_bag_requested")
	print("sinal enviado")
