extends Level

# Level Data
func _ready():
	levelNum = 2
	startTileLocation = Vector2i(-3, 2)
	startDirection = "right"
	energy = 5
	stars = 2
	tileCounts = {
		"left": 2,
		"right": 2,
		"up": 2,
		"down": 2,
		"dash": 0,
		"None": 0,
	}
