extends Node2D

var is_play_animation = true
var is_change = false

func _ready() -> void:
	set_physics_process(true)

func _physics_process(delta):
	if is_play_animation:
		$AnimationPlayer.play("popup")
	else:
		$AnimationPlayer.stop()
	
func _on_Timer_timeout():
	is_play_animation = false
	if is_change==true:
		get_tree().change_scene("res://scene/Main.tscn")
	else:
		is_change = true
