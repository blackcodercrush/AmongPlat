class_name Level3
extends Node2D

var Player = preload("res://script/Player.gd")

func _ready():
	set_physics_process(true)

func _physics_process(delta):
	if $Player.check_change_scene():
		get_tree().change_scene("res://scene/Win.tscn")
