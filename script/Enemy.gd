extends KinematicBody2D
var speed = 75
var velocity = Vector2(0, 0)

func _ready():
	set_physics_process(true)
	
func _physics_process(delta):
	velocity.x = -speed
	position += velocity * delta
