extends TileMap

func _ready():
	load_configs()
	
func load_configs() -> void:
	var roads : Array = get_child_roads()
	map_tiles_to_road_indexes(roads)
	
func get_child_roads() -> Array:
	return $Roads.get_children()
	
func map_tiles_to_road_indexes(roads: Array) -> void:
	
	for road in roads:
		var tiles_positions : Array = [];
		tiles_positions = get_tiles_positions_by_layer_index(road.LayerIndex)
		add_points_to_path_2d(road, tiles_positions)
		

func get_tiles_positions_by_layer_index(layer_index: int) -> Array:
	var cell_size : Vector2 = tile_set.tile_size
	var tiles_positions : Array = []
	
	for cell_position in get_used_cells(layer_index):
		var cell_center_position : Vector2
		cell_center_position = map_to_local(cell_position) + cell_size / 2
		tiles_positions.append(cell_center_position)
	
	return tiles_positions
	
func add_points_to_path_2d(road: Path2D, tiles_positions: Array) -> void:
	road.curve.clear_points()
	for tile_position in tiles_positions:
		road.curve.add_point(tile_position)
		
