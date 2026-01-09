extends Camera2D

func _ready():
	var tilemap = get_tree().current_scene.find_child("TileMap", true, false)
	if tilemap is TileMap:
		define_camera_limits(tilemap)

func define_camera_limits(map: TileMap):
	var limites_celulas = map.get_used_rect()
	var tamanho_celula = map.tile_set.tile_size	
	var escala = map.scale
	
	limit_left = limites_celulas.position.x * tamanho_celula.x * escala.x
	limit_top = limites_celulas.position.y * tamanho_celula.y * escala.y
	limit_right = limites_celulas.end.x * tamanho_celula.x * escala.x
	limit_bottom = limites_celulas.end.y * tamanho_celula.y * escala.y
