extends TileMap

# Level Data
const levelNum = 1
const startTileLocation : Vector2i = Vector2i(-4, 1)
const startDirection : String = "right"
const energy = 25
const tileCounts = {
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
	
func getTileCounts():
	return tileCounts
