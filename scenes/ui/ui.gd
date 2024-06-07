extends CanvasLayer

signal start_game()

@onready var main_menu = $Control/MainMenu
@onready var tutorial_screen = $Control/HowToPlay
@onready var game_player = $Control/GamePlayer
@onready var level_complete = $Control/LevelComplete
@onready var level_select = $Control/LevelSelect
@onready var about = $Control/About


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Main Menu Actions
func _on_main_menu_level_select():
	level_select.show()

func _on_main_menu_tutorial_screen():
	tutorial_screen.show()

func _on_main_menu_about():
	about.show()

# Info Screen Actions
func _on_info_back_to_main():
	main_menu.show()
	
	
# Game Player Actions
func _on_game_player_return_menu():
	main_menu.show()

func _on_game_player_level_win(level, stars, total):
	level_complete.updateInfo(level, stars, total)
	level_complete.show()


# Level Select Actions
func _on_level_select_back_to_main():
	main_menu.show()
	
func _on_level_select_load_level(level: int):
	game_player.loadLevel(level)


# Level Complete Actions
func _on_level_complete_back_to_main():
	main_menu.show()

func _on_level_complete_level_select():
	level_select.show()

func _on_level_complete_replay():
	game_player.resetLevel()
	game_player.show()
