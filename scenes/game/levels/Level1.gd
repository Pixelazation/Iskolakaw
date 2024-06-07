extends Level

# Level Data
func _ready():
	levelNum = 1
	startTileLocation = Vector2i(-3, -3)
	startDirection = "right"
	energy = 10
	stars = 2
	tileCounts = {
		"left": 1,
		"right": 3,
		"up": 1,
		"down": 3,
		"dash": 0,
		"None": 0,
	}
