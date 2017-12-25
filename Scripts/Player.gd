extends Area2D

var colliding_body = null
var scene_position = null
var direction = Vector2(1,0)
func _ready():
	connect("body_enter", self, "_on_body_enter")
	pass


func _on_body_enter(body):
	colliding_body = body
	pass

func move_to():
	var player_position = get_pos()
	player_position += direction*Vector2(Utils.Spr_Largeur,Utils.Spr_Hauteur)
	set_pos(player_position)
	pass

func get_scene():
	var tilemap = get_node("../TileMap")
	var position = get_pos()
	var player_grid_pos = tilemap.world_to_map(position)
	return tilemap.grid[player_grid_pos.x][player_grid_pos.y]
	pass