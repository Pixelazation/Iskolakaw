extends Node2D

@onready var isko = $Isko
@onready var play_grid: Level = $Level
@onready var timer = $Timer

@onready var star_collect = $StarCollect
@onready var energy_collect = $EnergyCollect
@onready var pop_sound = $PopSound


# TileMap Constants
const tileSource = 2

const background = 0
const environment = 1
const player = 2

# Constants
const slideDuration = 0.4

var running = false
var finish = false

var currDirection : Vector2i    # CURRENT ENTITY "STATE" #

var energy : int

var currentLevel: int

# TILE SELECT DATA

var selectedTile = "None"

var consumables = ["star", "energy"]

var starTotal: int
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
	#"left": Vector2i(17, 10),
	#"right": Vector2i(16, 10),
	#"up": Vector2i(16, 11),
	#"down": Vector2i(17, 11)
	
	"left": Vector2i(3, 1),
	"right": Vector2i(1, 1),
	"up": Vector2i(0, 1),
	"down": Vector2i(2, 1)
}

# OPERATIONS #

var directionDict = {
	"left": Vector2i.LEFT,
	"right": Vector2i.RIGHT,
	"up": Vector2i.UP,
	"down": Vector2i.DOWN,
	
	"tempLeft": Vector2i.LEFT,
	"tempRight": Vector2i.RIGHT,
	"tempUp": Vector2i.UP,
	"tempDown": Vector2i.DOWN,
	
	"stop": Vector2i.ZERO
}

var directionToString = {
	Vector2i.LEFT: "left",
	Vector2i.RIGHT: "right",
	Vector2i.UP: "up",
	Vector2i.DOWN: "down",
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

func isConsumable(cell):
	var envData = play_grid.get_cell_tile_data(environment, cell)
	var floorData = play_grid.get_cell_tile_data(background, cell)
	
	return floorData != null and (envData == null or envData.get_custom_data("consumable"))
		
func attemptPlace():
	
	if selectedTile != "erase" and (tileCounts[selectedTile] <= 0 or running):
		return
	
	var localMousePos = play_grid.local_to_map(get_local_mouse_position())
	
	if !isEditableCell(localMousePos):
		return
		
	var oldTileData = readCell(localMousePos)
	
	if selectedTile == "erase":
		play_grid.erase_cell(environment, localMousePos)
		if oldTileData != "empty":
			pop_sound.play()
		
	else:
		play_grid.set_cell(environment, localMousePos, tileSource, tileAtlasCoords[selectedTile])
		tileCounts[selectedTile] -= 1
		pop_sound.play()
		
	
	if oldTileData != "empty":
		tileCounts[oldTileData] += 1
	

	
# SIMULATION CONTROL #
	
func changeAndMove():
	if energy <= 0:
		get_parent().restartRun()
		return
	
	var next = _currCell() + currDirection
	
	if readCell(next) == "obstacle":
		currDirection = -1 * currDirection
		next = _currCell() + currDirection
		
	isko.startRun(directionToString[currDirection])
	
	slideTo(next)
	
	if (readCell(next) in directionDict):
		currDirection = directionDict[readCell(next)]
	
		
	if readCell(next) == "energy":
		energy += 5
		energy_collect.play()
		
	energy -= 1
		
	if readCell(next) == "star":
		starsCollected += 1
		star_collect.play()
		
	if isConsumable(next):
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
	currDirection = directionDict[play_grid.getStartDirection()]
	energy = play_grid.getStartEnergy()
	starTotal = play_grid.getStars()
	
	var levelTileCounts = play_grid.getTileCounts() 
	for key in levelTileCounts:
		tileCounts[key] = levelTileCounts[key]
		
	isko.idlePlay(directionToString[currDirection])
		
# Player Tile Information
func savePlayerTiles():
	var placedTiles : Dictionary = {}
	
	for tile in tileAtlasCoords:
		placedTiles[tile] = play_grid.get_used_cells_by_id(environment, tileSource, tileAtlasCoords[tile])
		
	return placedTiles
		
func loadPlayerTiles(placedTiles: Dictionary):
	for tile in tileAtlasCoords:
		for location in placedTiles[tile]:
			play_grid.set_cell(environment, location, tileSource, tileAtlasCoords[tile])
			tileCounts[tile] -= 1

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
		isko.position = play_grid.getStartPosition()


func _on_timer_timeout():
	if finish:
		toggleRun()
		get_parent().level_win.emit(currentLevel, starsCollected, starTotal)
		print("burh")
	else:
		changeAndMove()
