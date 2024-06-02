extends Control

@onready var level_complete = $MarginContainer/VBoxContainer/LevelComplete
@onready var star_count = $MarginContainer/VBoxContainer/StarCount

signal replay()
signal back_to_main()
signal level_select()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func updateInfo(level: int, stars: int, total: int):
	level_complete.text = "Level " + str(level) + "\n Complete!"
	star_count.text = str(stars) + " / " + str(total) + " stars"


func _on_main_menu_button_pressed():
	hide()
	back_to_main.emit()


func _on_level_button_pressed():
	hide()
	level_select.emit()
	
