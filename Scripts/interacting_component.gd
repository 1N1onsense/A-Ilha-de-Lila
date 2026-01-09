extends Node2D

@onready var interact_label: Label = $InteractLabel
var current_interactions := []
var can_interact := true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact:
		if current_interactions:
			can_interact = false
			interact_label.hide()
			
			await current_interactions[0].interact.call()
			
			can_interact = true

func _process(_delta: float) -> void:
	print("1")
	if current_interactions and can_interact:
		print("2")
		current_interactions.sort_custom(_sort_by_nearest)
		if current_interactions[0].is_interactable:
			print("3")
			interact_label.text = current_interactions[0].interact_name
			interact_label.show()
	else:
		print("4")
		interact_label.hide()

func _sort_by_nearest(area1, area2):
	print("5")
	var area1_dist = global_position.distance_to(area1.global_position)
	var area2_dist = global_position.distance_to(area2.global_position)
	print(area1_dist < area2_dist)
	return area1_dist < area2_dist

# Adiciona interação ao entrar no range
func _on_interact_range_area_entered(area: Area2D) -> void:
	print("ELE ENTROU VI BOY")
	current_interactions.push_back(area)

# Remove interação ao sair do range
func _on_interact_range_area_exited(area: Area2D) -> void:
	print("agr saiu")
	current_interactions.erase(area)
