extends TileMap

var tile_size = get_cell_size()
var half_tile_size = tile_size/2

var grid_size = Vector2(16,16)
var grid =[]


func _ready():
	## Init grid
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)
	
	var children = get_children()
	for child in children:
		grid[child.get_pos().x/tile_size.x][child.get_pos().y/tile_size.y] = child
	pass

func _get_scene(position):
	var grid_pos = world_to_map(position)
	return grid[grid_pos.x][grid_pos.y]

func remove_selectionnable():
	for x in get_node("Selectionnable_tile").get_children():
		x.queue_free()
	pass

