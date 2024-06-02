extends Control

@onready var level_display = $MarginContainer/VBoxContainer/GameDisplay/LevelDisplay

@onready var select_left = $MarginContainer/VBoxContainer/TileSelector/MarginContainer/TileSelectDisplay/SelectLeft
@onready var select_right = $MarginContainer/VBoxContainer/TileSelector/MarginContainer/TileSelectDisplay/SelectRight
@onready var select_dash = $MarginContainer/VBoxContainer/TileSelector/MarginContainer/TileSelectDisplay/SelectDash
@onready var select_up = $MarginContainer/VBoxContainer/TileSelector/MarginContainer/TileSelectDisplay/SelectUp
@onready var select_down = $MarginContainer/VBoxContainer/TileSelector/MarginContainer/TileSelectDisplay/SelectDown

@onready var energy_count = $MarginContainer/VBoxContainer/GameDisplay/EnergyCount
@onready var star_count = $MarginContainer/VBoxContainer/GameDisplay/StarCount
@onready var level_number = $MarginContainer/VBoxContainer/HBoxContainer/LevelNumber


signal return_menu()
signal toggle_run()
signal reset()

signal level_win(level, stars, total)

func loadLevel(level: int):
	show()
	level_display.play.loadLevel(level)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Update Tile Counts
	select_left.text = str(level_display.getTileCount("left"))
	select_right.text = str(level_display.getTileCount("right"))
	select_dash.text = str(level_display.getTileCount("dash"))
	select_up.text = str(level_display.getTileCount("up"))
	select_down.text = str(level_display.getTileCount("down"))
	
	# Update Energy
	energy_count.text = "Energy\n" + str(level_display.getEnergy())
	
	# Update Star Progress
	star_count.text = "Stars\n" + level_display.getStarProgress()
	
	# Update Level
	level_number.text = "Level " + level_display.getLevel()


func _on_return_button_pressed():
	return_menu.emit()
	hide()
	# more code for game stuff here maybe
	level_display.resetLevel()

func _on_start_button_pressed():
	level_display.toggleRun()

func _on_reset_button_pressed():
	level_display.resetLevel()


func _on_level_display_level_win(level, stars, total):
	hide()
	level_win.emit(level, stars, total)
	level_display.resetLevel()


func _on_draw():
	select_left.button_pressed = false
	select_right.button_pressed = false
	select_dash.button_pressed = false
	select_up.button_pressed = false
	select_down.button_pressed = false
