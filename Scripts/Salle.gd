extends StaticBody2D

var type = "SALLE"
var can_be_clicked = true
var anim = null

func _ready():
	anim = get_node("AnimationPlayer")
	pass

func _on_mouse_enter():
	anim.play("open_click_anim")
	pass

func _on_mouse_exit():
	if anim.is_playing():
		anim.stop()
		get_node("AnimatedSprite").set_frame(0)
	pass

func _clicked():
	get_node("AnimatedSprite").set_frame(1)
	pass