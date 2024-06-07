extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D


func startRun(direction):
	sprite.play(direction + "-walk")
	
func idlePlay(direction):
	sprite.play(direction + "-idle")
