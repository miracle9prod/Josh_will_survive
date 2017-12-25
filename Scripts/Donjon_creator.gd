extends Node

var salle_scn = preload("res://Scenes/Salle.tscn")

onready var nb_h_tile = Utils.HAUTEUR/Utils.Spr_Hauteur
onready var nb_l_tile = Utils.LARGEUR/Utils.Spr_Largeur

onready var tilemap = []


func _ready():
	# Create tilemap
	tilemap.resize(nb_l_tile)
	for l in range(nb_l_tile):
		tilemap[l] = []
		tilemap[l].resize(nb_h_tile)
	
	print(tilemap)
	
	for l in range(nb_l_tile):
		for h in range(nb_h_tile):
			var salle_inst = salle_scn.instance()
			salle_inst.set_pos(Vector2(l*Utils.Spr_Largeur,h*Utils.Spr_Hauteur))
			tilemap[l][h] = salle_inst
			pass
	
	
	for l in range(nb_l_tile):
		for h in range(nb_h_tile):
			print(str(l) + ":" + str(h))
			if tilemap[h][l]:
				add_child(tilemap[h][l])
				pass
	pass
