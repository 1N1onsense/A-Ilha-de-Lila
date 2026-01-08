extends Node2D

# Usar getter para garantir que pegamos o player mesmo que ele entre na cena depois
var player: Node2D:
	get:
		if is_instance_valid(player):
			return player
		var nodes = get_tree().get_nodes_in_group("player")
		if nodes.size() > 0:
			player = nodes[0]
			return player
		return null

@onready var label = $label

const base_text = "[E] para "

var areas_ativas: Array[AreaInteracao] = [] # Tipagem estrita ajuda no autocomplete
var pode_interagir = true

func registrar_area(area):
	if not areas_ativas.has(area):
		areas_ativas.push_back(area)
	
func excluir_area(area):
	var index = areas_ativas.find(area)
	if index != -1:
		areas_ativas.remove_at(index)

func _process(_delta):
	# Limpeza de segurança: remove referências nulas se um objeto foi deletado
	areas_ativas = areas_ativas.filter(func(a): return is_instance_valid(a))
	
	if areas_ativas.is_empty() or not pode_interagir or player == null:
		label.hide()
		return

	# OTIMIZAÇÃO: Não precisamos ordenar o array inteiro toda hora.
	# Apenas precisamos encontrar o mais próximo.
	var area_mais_proxima = _obter_area_mais_proxima()
	
	if area_mais_proxima:
		label.text = base_text + area_mais_proxima.action_name
		# Centralização
		label.global_position = area_mais_proxima.global_position
		label.global_position.y -= 36
		label.global_position.x -= label.size.x / 2
		label.show()

func _obter_area_mais_proxima():
	var menor_distancia = INF
	var area_alvo = null
	
	for area in areas_ativas:
		var dist = player.global_position.distance_squared_to(area.global_position)
		if dist < menor_distancia:
			menor_distancia = dist
			area_alvo = area
			
	return area_alvo

func _input(event):
	if event.is_action_pressed("interagir") and pode_interagir:
		# Filtra novamente para garantir segurança no momento do input
		areas_ativas = areas_ativas.filter(func(a): return is_instance_valid(a))
		
		if areas_ativas.size() > 0:
			var area_alvo = _obter_area_mais_proxima()
			if area_alvo:
				pode_interagir = false
				label.hide()
				
				# Chama a função diretamente
				# Certifique-se que interagir() retorna void ou é 'awaitable'
				await area_alvo.interagir()
				
				pode_interagir = true
