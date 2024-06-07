extends Level

# Level Data
func _ready():
	levelNum = 3
	startTileLocation = Vector2i(-4, -2)
	startDirection = "right"
	energy = 18
	stars = 2
	tileCounts = {
		"left": 1,
		"right": 3,
		"up": 1,
		"down": 3,
		"dash": 0,
		"None": 0,
	}
