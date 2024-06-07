extends Level

# Level Data
func _ready():
	levelNum = 5
	startTileLocation = Vector2i(-3, 2)
	startDirection = "down"
	energy = 15
	stars = 4
	tileCounts = {
		"left": 3,
		"right": 3,
		"up": 3,
		"down": 3,
		"dash": 0,
		"None": 0,
	}
