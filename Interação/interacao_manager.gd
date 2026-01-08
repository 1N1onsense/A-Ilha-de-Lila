extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var label = $label

const base_text = "[E] para "

var areas_ativas = []
var pode_interagir = true

func registrar_area(area: AreaInteracao):
	areas_ativas.push_back(area)
	
func excluir_area(area: AreaInteracao):
	var index = areas_ativas.find(area)
	if index != -1:
		areas_ativas.remove_at(index)
		
func _process(delta):
	if areas_ativas.size() > 0 && pode_interagir:
		areas_ativas.sort_custom(_sort_by_distance_to_player)
		label.text = base_text + areas_ativas[0].action_name
		label.global_position = areas_ativas[0].global_position
		label.global_position.y -= 36
		label.global_position.x -= label.size.x / 2
		label.show()
	else:
		label.hide()
		
func _sort_by_distance_to_player(area1, area2):
	var area1_to_player = player.global_position.distance_to(area1.global_position)
	var area2_to_player = player.global_position.distance_to(area2.global_position)
	return area1_to_player < area2_to_player 

func _input(event):
	if event.is_action_pressed("interagir") && pode_interagir:
		if areas_ativas.size()>0:
			pode_interagir = false
			label.hide()
			
			await areas_ativas[0].interagir.call()
			
			pode_interagir = true
