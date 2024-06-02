extends Control

@onready var level_button_container = $MarginContainer/VBoxContainer/MarginContainer/GridContainer

signal back_to_main()
signal load_level(level: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	var levelButtons = level_button_container.get_children()
	
	# Link buttons to function
	for button in levelButtons:
		button.pressed.connect(_on_level_button_pressed.bind(int(button.text)))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_level_button_pressed(level: int):
	hide()
	load_level.emit(level)

func _on_back_button_pressed():
	hide()
	back_to_main.emit()


func _on_draw():
	# Unselect buttons
	var levelButtons = level_button_container.get_children()
	
	for button in levelButtons:
		button.button_pressed = false
