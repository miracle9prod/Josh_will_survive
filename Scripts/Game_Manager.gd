extends Node

# Variables
onready var choose_selection = preload("res://Scenes/choose_case_selection.tscn")
onready var mouse = get_node("../Mouse_controller")
onready var player = get_node("../Player")
onready var tilemap = get_node("../TileMap")
var player_can_move = false
var scene_accessible_shown = null

enum ROUND_PHASE {INIT_ROUND,BEGIN_ROUND,MOVE_PLAYER,END_ROUND}

##############################################################################

func _ready():
	set_fixed_process(true)
	mouse.connect("scene_clicked", self, "_on_scene_clicked")
	
	ROUND_PHASE = INIT_ROUND
	pass

func _fixed_process(delta):
	
	on_round()
	
	pass


func on_round():
	"""
	Suite d'actions à faire pendant un tours
	Comprend l'activation des sorts
	Bouger le personnage
	L'entree en combat
	La résolution des actions en fin de tours
	"""
	if ROUND_PHASE == INIT_ROUND:
		scene_accessible_shown = false
		tilemap.remove_selectionnable()
		ROUND_PHASE = BEGIN_ROUND
		
	elif ROUND_PHASE == BEGIN_ROUND:
		ROUND_PHASE = MOVE_PLAYER
		
	elif ROUND_PHASE == MOVE_PLAYER:
		if !scene_accessible_shown:
			show_scene_accessible()
		if player_can_move: 
			move_player()
			ROUND_PHASE = END_ROUND
		
	elif ROUND_PHASE == END_ROUND:
		ROUND_PHASE = INIT_ROUND
		pass
		
	pass

##############################################################################

func move_player():
	player.move_to()
	player_can_move = false
	pass

func _on_scene_clicked():
	player_can_move = true
	pass

func show_scene_accessible():
	var player_scene = player.get_scene()
	var player_position = player.get_pos()
	var scenes_around = {"haut":null,"bas":null,"droite":null,"gauche":null}
	scenes_around.haut = tilemap._get_scene(Vector2(player_position.x,player_position.y-Utils.Spr_Hauteur))
	scenes_around.bas = tilemap._get_scene(Vector2(player_position.x,player_position.y+Utils.Spr_Hauteur))
	scenes_around.droite = tilemap._get_scene(Vector2(player_position.x+Utils.Spr_Largeur,player_position.y))
	scenes_around.gauche = tilemap._get_scene(Vector2(player_position.x-Utils.Spr_Largeur,player_position.y))
		
	for x in scenes_around:
		if scenes_around[x] != null:
			var choose_selection_inst = choose_selection.instance()
			var selection_inst_pos = scenes_around[x].get_pos()
			choose_selection_inst.set_pos(selection_inst_pos)
			choose_selection_inst.grid_pos = tilemap.world_to_map(selection_inst_pos)
			
			if selection_inst_pos.x > player.get_pos().x :
				choose_selection_inst.pos_to_player = Vector2(1,0)
			elif selection_inst_pos.x < player.get_pos().x :
				choose_selection_inst.pos_to_player = Vector2(-1,0)
			elif selection_inst_pos.y > player.get_pos().y :
				choose_selection_inst.pos_to_player = Vector2(0,1)
			elif selection_inst_pos.y > player.get_pos().y :
				choose_selection_inst.pos_to_player = Vector2(0,-1)
			
			tilemap.get_node("Selectionnable_tile").add_child(choose_selection_inst)
		
	scene_accessible_shown = true
	pass

