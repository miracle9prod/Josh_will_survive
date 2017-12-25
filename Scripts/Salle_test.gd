extends Sprite

onready var body = get_node("StaticBody2D")
onready var hidden = false
func _ready():
	body.connect("mouse_enter", self, "_mouse_enter")
	body.connect("mouse_exit", self, "_mouse_exit")
	set_hidden(hidden)
	pass

func _mouse_enter():
	if !hidden:
		set_hidden(true)
		hidden = true
	pass

func _mouse_exit():
	if hidden:
		set_hidden(false)
		hidden = false
	pass