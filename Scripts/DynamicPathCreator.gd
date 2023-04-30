extends TileMap
var RoadPathScript : GDScript = load("res://Scripts/RoadPath.gd")

func _ready():
	load_configs()
	
func load_configs() -> void:
	load_tiles_as_paths_to_follow()
	
		
func load_tiles_as_paths_to_follow() -> void:
	var tile_map_road_layer_indexes : Array = get_tile_map_road_layer_indexes()
	for tile_map_road_layer_index in tile_map_road_layer_indexes:
		set_dinamic_follow_paths_to_road(tile_map_road_layer_index)

func get_tile_map_road_layer_indexes() -> Array:
	var n_of_layers : int = get_layers_count()
	
	var road_index_layers : Array = []
	for layer_index in range(n_of_layers):
		if ('road' in get_layer_name(layer_index)):
			road_index_layers.append(layer_index)
			
	return road_index_layers
	
func set_dinamic_follow_paths_to_road(tile_map_road_layer_index: int) -> void:
	var tiles_positions : Array = []
	tiles_positions = get_tiles_positions_by_layer_index(
		tile_map_road_layer_index
	)
	add_points_to_path_2d(tiles_positions, tile_map_road_layer_index)
			

func get_tiles_positions_by_layer_index(layer_index: int) -> Array:
	var cell_size : Vector2 = tile_set.tile_size
	var tiles_positions : Array = []
	
	for cell_position in get_used_cells(layer_index):
		var cell_center_position : Vector2
		cell_center_position = map_to_local(cell_position) + cell_size / 2
		tiles_positions.append(cell_center_position)
	
	return tiles_positions
	
func add_points_to_path_2d(tiles_positions: Array, tile_map_index: int) -> void:
	var road_path : Path2D = Path2D.new()
	road_path.curve = Curve2D.new();
	road_path.set_script(RoadPathScript)
	road_path.RoadIndex = tile_map_index
	
	var curve : Curve2D = road_path.curve
	
	add_child(road_path)
	
	for tile_position in tiles_positions:
		curve.add_point(tile_position)
		
