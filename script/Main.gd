extends Node2D

func _ready():
	set_physics_process(true)
	
func _physics_process(delta):
	$Button/AnimationPlayer.play("popup")
	if $Button.pressed:
		get_tree().change_scene("res://scene/Level/Level1.tscn")
		
