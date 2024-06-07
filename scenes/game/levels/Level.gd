extends TileMap
class_name Level

# Level Data
var levelNum : int
var startTileLocation : Vector2i
var startDirection : String
var energy : int
var stars : int
var tileCounts : Dictionary = {
	"left": 5,
	"right": 5,
	"up": 5,
	"down": 5,
	"dash": 5,
	"None": 0,
}

# Helpers
func getLevelNum():
	return levelNum

func getStartPosition():
	return map_to_local(startTileLocation)
	
func getStartDirection():
	return startDirection
	
func getStartEnergy():
	return energy
	
func getStars():
	return stars
	
func getTileCounts():
	return tileCounts
