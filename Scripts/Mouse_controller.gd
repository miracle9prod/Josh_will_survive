extends Node2D

# Variables
var time_to_click = 1
var tile_clicked = null
onready var tilemap = get_node("../TileMap")

# Signaux
signal mouse_clicked
signal scene_clicked




func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	var global_mouse_pos = get_global_mouse_pos()
	set_pos(global_mouse_pos)
	
	# Recupere l'objet qui est en contact avec la souris
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and time_to_click <= 0:
		var mouse_grid_pos = tilemap.world_to_map(global_mouse_pos)
		tile_clicked = tilemap.grid[mouse_grid_pos.x][mouse_grid_pos.y]
		
		if tilemap.get_node("Selectionnable_tile").get_children().size() > 0:
			for child in tilemap.get_node("Selectionnable_tile").get_children():
				if mouse_grid_pos == child.grid_pos :
					get_node("../Player").direction = child.pos_to_player
					emit_signal("scene_clicked")
#		if tile_clicked:
#			if tile_clicked.can_be_clicked:
#				tile_clicked._clicked()
#				emit_signal("scene_clicked")
		
		time_to_click = 1
	
	
	
	#### Reset tout ce qui doit se reset en fin de frame
	# Met a jour le temps avant de pouvoir clicker avec la souris
	if time_to_click > -1:
		time_to_click -= delta
	
	tile_clicked = null
	pass
	
