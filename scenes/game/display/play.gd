extends Node2D

@onready var isko = $Isko
@onready var play_grid: TileMap = $PlayGrid
@onready var timer = $Timer

# TileMap Layers
const background = 0
const environment = 1
const player = 2

# Constants
const slideDuration = 0.5

var running = false
var finish = false

var currDirection : Vector2i    # CURRENT ENTITY "STATE" #

var energy : int

var currentLevel: int

# TILE SELECT DATA

var selectedTile = "None"

var consumables = ["star", "energy"]

var starTotal = 3
var starsCollected = 0

var tileCounts : Dictionary = {
	#"left": 5,
	#"right": 5,
	#"up": 5,
	#"down": 5,
	#"dash": 5,
	#"None": 0,
}

var tileAtlasCoords = {
	"left": Vector2i(17, 10),
	"right": Vector2i(16, 10),
	"up": Vector2i(16, 11),
	"down": Vector2i(17, 11),
	"dash": Vector2i(20, 10),
}

# OPERATIONS #

var directionDict = {
	"left": Vector2i.LEFT,
	"right": Vector2i.RIGHT,
	"up": Vector2i.UP,
	"down": Vector2i.DOWN,
	"stop": Vector2i.ZERO
}



# CELL FUNCTIONS #

func _currCell():
	return play_grid.local_to_map(isko.position)

func slideTo(cell: Vector2i):
	var tween = get_tree().create_tween()
	tween.tween_property($Isko, "position", play_grid.map_to_local(cell), slideDuration)
	
func readCell(cell):
	var tileData = play_grid.get_cell_tile_data(environment, cell)
	
	if tileData == null:
		return "empty"
	
	return tileData.get_custom_data("environment")
	
func isEditableCell(cell):
	var envData = play_grid.get_cell_tile_data(environment, cell)
	var floorData = play_grid.get_cell_tile_data(background, cell)
	
	return floorData != null and (envData == null or envData.get_custom_data("playerEditable"))
	

		
func attemptPlace():
	
	if selectedTile != "erase" and (tileCounts[selectedTile] <= 0 or running):
		return
	
	var localMousePos = play_grid.local_to_map(get_local_mouse_position())
	
	if !isEditableCell(localMousePos):
		return
		
	var oldTileData = readCell(localMousePos)
	
	if selectedTile == "erase":
		play_grid.erase_cell(environment, localMousePos)
	else:
		play_grid.set_cell(environment, localMousePos, 1, tileAtlasCoords[selectedTile])
		tileCounts[selectedTile] -= 1
	
	if oldTileData != "empty":
		tileCounts[oldTileData] += 1
	

	
# SIMULATION CONTROL #
	
func changeAndMove():
	if energy <= 0:
		# code for stop/fail
		return
	
	var next = _currCell() + currDirection
	
	if readCell(next) == "obstacle":
		currDirection = -1 * currDirection
		next = _currCell() + currDirection
	
	slideTo(next)
	
	if (readCell(next) in directionDict):
		currDirection = directionDict[readCell(next)]
	
		
	if readCell(next) == "energy":
		energy += 5
		
	energy -= 1
		
	if readCell(next) == "star":
		starsCollected += 1
		
	if readCell(next) in consumables:
		play_grid.erase_cell(environment, next)
		
	if readCell(next) == "stop":
		finish = true
		# Winning code


func loadLevel(level: int):
	remove_child(play_grid)
	print("Loading: res://scenes/game/levels/Level" + str(level) + ".tscn")
	play_grid = load("res://scenes/game/levels/Level" + str(level) + ".tscn").instantiate()
	add_child(play_grid)
	print(play_grid == null)
	fetchData()

func fetchData():
	currentLevel = play_grid.getLevelNum()
	isko.position = play_grid.getStartPosition()
	print(isko.position)
	currDirection = directionDict[play_grid.getStartDirection()]
	energy = play_grid.getStartEnergy()
	
	var levelTileCounts = play_grid.getTileCounts() 
	for key in levelTileCounts:
		tileCounts[key] = levelTileCounts[key]

# Called when the node enters the scene tree for the first time.
func _ready():
	fetchData()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if Input.is_action_just_pressed("Click"):
		attemptPlace()

func toggleRun():
	running = !running
	if running:
		timer.start()
	else:
		timer.stop()


func _on_timer_timeout():
	if finish:
		toggleRun()
		get_parent().level_win.emit(currentLevel, starsCollected, starTotal)
		print("burh")
	else:
		changeAndMove()
