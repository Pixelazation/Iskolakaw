extends Area2D

var is_hover = false
var is_selected = false

func _on_mouse_entered():
	is_hover = true
	
func _on_mouse_exited():
	is_hover = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	if is_selected:
		position = get_viewport().get_mouse_position()

func _input(event):
	if event.is_action_pressed("Click"):
		print("clicked!")
		if is_selected:
			is_selected = !is_selected
		elif is_hover:
			is_selected = !is_selected
