extends Control

signal level_select()
signal tutorial_screen()

func _on_level_select_button_pressed():
	level_select.emit()
	hide()
	
func _on_tutorial_button_pressed():
	tutorial_screen.emit()
	hide()
	
func _on_quit_button_pressed():
	get_tree().quit()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
