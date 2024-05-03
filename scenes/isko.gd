extends CharacterBody2D

const SPEED = 64.0

@onready var collision_shape_2d = $Collider
@onready var isko_sprite = $IskoSprite
@onready var animation_player = $AnimationPlayer

var direction := Vector2.RIGHT

var is_running = false


func _physics_process(delta):
	if is_running:
		velocity = lerp(velocity, direction.normalized() * SPEED, SPEED * delta)
		move_and_slide()

func _input(event):
	if event.is_action_pressed("IskoStart"):
		toggleStart()
			
	

func changeDirection(newDirection):
	direction = newDirection
	
func toggleStart():
	is_running = !is_running
