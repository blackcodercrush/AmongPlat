class_name Ball
extends RigidBody2D

var disabled = false

func _ready():
	$Timer.start()
	
func disable():
	if disabled:
		return
	$AnimationPlayer.play("disabled")
	disabled = true
