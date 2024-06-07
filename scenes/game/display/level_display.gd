extends GridContainer

@onready var play = $Play

@export var PLAY_SCENE: PackedScene

signal level_win(level, stars, total)
signal stop_run()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func toggleRun():
	play.toggleRun()

# LEVEL DATA #

func getTileCount(tile):
	return play.tileCounts[tile]
	
func getEnergy():
	return play.energy
	
func getStarProgress():
	return str(play.starsCollected) + " / " + str(play.starTotal)
	
func getLevel():
	return str(play.currentLevel)
	
func restartRun():
	var placedTiles : Dictionary = play.savePlayerTiles()
	resetLevel()
	play.loadPlayerTiles(placedTiles)
	
func resetLevel():
	var level = play.currentLevel
	remove_child(play)
	play = PLAY_SCENE.instantiate()
	add_child(play)
	play.loadLevel(level)
	stop_run.emit()
	

# TILE DATA #

func _on_select_left_pressed():
	play.selectedTile = "left"

func _on_select_right_pressed():
	play.selectedTile = "right"

func _on_select_dash_pressed():
	play.selectedTile = "dash"

func _on_select_up_pressed():
	play.selectedTile = "up"

func _on_select_down_pressed():
	play.selectedTile = "down"

func _on_erase_button_pressed():
	play.selectedTile = "erase"



