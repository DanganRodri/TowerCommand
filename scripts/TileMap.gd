extends TileMap

var graph = AStarGrid2D.new()

func _ready():
	
	var tilemap_size = get_used_rect().end - get_used_rect().position
	var mapRect = Rect2i(Vector2i.ZERO, tilemap_size)
	
	var tile_size =  get_tileset().tile_size
	
	graph.region = mapRect
	graph.cell_size = tile_size
	graph.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	graph.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	graph.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	graph.update()
	
	for i in tilemap_size.x:
		for j in tilemap_size.y:
			var coords = Vector2i(i,j)
			var tile_data = get_cell_tile_data(0, coords)
			if tile_data and tile_data.get_custom_data("type") == "wall":
				graph.set_point_solid(coords)
			
	pass
	
