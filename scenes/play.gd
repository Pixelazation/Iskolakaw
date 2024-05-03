extends Node2D

@export var ISKO: PackedScene
@export var ARROW: PackedScene
@export var GRID: PackedScene

@onready var isko = $Isko
@onready var play_grid: TileMap = $PlayGrid

const background = 0
const environment = 1
const player = 2

var tileOffset = Vector2(8, 8)

var directionDict = {
	"left": Vector2.LEFT,
	"right": Vector2.RIGHT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

# Called when the node enters the scene tree for the first time.
func _ready():
	#var isko = ISKO.instantiate()
	#isko.global_position = position
	#add_child(isko)
	#print("isko ready")
	#print(isko.global_position)
	#
	##var arrow = ARROW.instantiate()
	##arrow.global_position = position
	##add_child(arrow)
	##print("arrow ready")
	##print(arrow.global_position)
	#
	#var grid = GRID.instantiate()
	#grid.global_position = get_viewport_rect().size / 2.0
	#add_child(grid)
	#print("grid ready")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var currCell = play_grid.local_to_map(isko.position - tileOffset)
	
	
	var tileData : TileData = play_grid.get_cell_tile_data(environment, currCell)
	
	var cellCenter = play_grid.map_to_local(currCell)
	
	if tileData == null:
		return
	
	var tileVal = tileData.get_custom_data("environment")
	
	print("Difference is ", cellCenter.distance_to(isko.position))
	
	if tileVal == "start" and !isko.is_running:
		isko.position = cellCenter
		return
		
	if tileVal == "stop" and cellCenter.distance_to(isko.position) < 1.5:
		isko.position = cellCenter
		isko.is_running = false
		return
	
	if tileVal in directionDict and cellCenter.distance_to(isko.position) < 1.5:
		isko.changeDirection(directionDict[tileVal])
		print(directionDict[tileVal])
