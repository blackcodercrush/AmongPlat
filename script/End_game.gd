extends Node2D

func _ready():
	set_physics_process(true)
	
func _physics_process(delta):
	$AnimationPlayer.play("rotate")
	if ($Button.pressed==true):
		get_tree().quit()
