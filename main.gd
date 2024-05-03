extends Node2D

@export var PLAY_SCENE: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	var play = PLAY_SCENE.instantiate()
	play.global_position = get_viewport_rect().size / 2.0
	add_child(play)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
