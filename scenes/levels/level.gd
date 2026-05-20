extends Node2D

var plant_scene = preload("res://scenes/objects/plant.tscn")
var used_cells: Array[Vector2i]
@onready var player = $Objects/Player
	
	
func _on_player_tool_use(tool: Enum.Tool, post: Vector2) -> void:
	var grid_coord: Vector2i = Vector2i(int(post.x / Data.TILE_SIZE),int (post.y / Data.TILE_SIZE))
	grid_coord.x += -1 if post.x < 0 else 0
	grid_coord.y += -1 if post.y < 0 else 0
	var has_soild = grid_coord in $Layers/SoilLayer.get_used_cells()
	match tool:
		Enum.Tool.HOE:
			var cell = $Layers/GrassLayer.get_cell_tile_data(grid_coord) as TileData
			if cell and cell.get_custom_data('farmable'):
				$Layers/SoilLayer.set_cells_terrain_connect([grid_coord], 0, 0)
		Enum.Tool.WATER:
			if has_soild:
				$Layers/SoilWaterLayer.set_cell(grid_coord, 1, Vector2i(randi_range(0,2),0))		
		Enum.Tool.FISH:
			if not grid_coord in $Layers/GrassLayer.get_used_cells():
				print('fishing')
		Enum.Tool.SEED:
			if has_soild and grid_coord not in used_cells:
				var plant = plant_scene.instantiate()
				plant.setup(grid_coord, $Objects)
				used_cells.append(grid_coord)
		Enum.Tool.AXE, Enum.Tool.SWORD:
			for object in get_tree().get_nodes_in_group('Objects'):
				if object.position.distance_to(post) < 20:
					object.hit(tool)
			
