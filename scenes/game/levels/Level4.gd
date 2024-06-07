extends Level

# Level Data
func _ready():
	levelNum = 4
	startTileLocation = Vector2i(-4, 1)
	startDirection = "right"
	energy = 25
	stars = 3
	tileCounts = {
		"left": 4,
		"right": 4,
		"up": 4,
		"down": 4,
		"dash": 4,
		"None": 0,
	}
