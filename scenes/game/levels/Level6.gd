extends Level

# Level Data
func _ready():
	levelNum = 6
	startTileLocation = Vector2i(-4, -4)
	startDirection = "right"
	energy = 20
	stars = 4
	tileCounts = {
		"left": 4,
		"right": 1,
		"up": 4,
		"down": 1,
		"dash": 0,
		"None": 0,
	}
