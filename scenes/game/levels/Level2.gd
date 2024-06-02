extends TileMap

# Level Data
const levelNum = 2
const startTileLocation : Vector2i = Vector2i(-3, -3)
const startDirection : String = "right"
const energy = 15
const tileCounts = {
	"left": 1,
	"right": 3,
	"up": 1,
	"down": 3,
	"dash": 0,
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
	
func getTileCounts():
	return tileCounts
