class_name Player
extends RigidBody2D
var jump_force = 420 - 140
var jump_velocity = 350 - 140
var speed = 50
var max_level = 2
var level = 1
var jump_count = 0
var death_count = 0
var shoot_time = 1e20
var step = 5
var is_death = false
var shooting = false
var jumping = false
var stop_jump = false
var is_change_scene = false
var is_down = false
var Ball = preload("res://scene/Ball.tscn")

func _init():
	pass
	
func _ready():
	set_physics_process(true)
	set_camera_limit()
	$Particles2D.emitting = false
	
func _physics_process(delta):
	#debug()
	#Shoot logic
	var shoot = Input.is_action_pressed("space")
	if shoot and not shooting:
		call_ball()
	else:
		shoot_time += step
	if is_death == false and is_change_scene==false and is_down==false:
		var velocity = Vector2(0, 0)
		if (Input.is_action_pressed("right")):
			$animsi.flip_h = false
			$animsi.play("run")
			linear_velocity.x = speed
		elif (Input.is_action_pressed("left")):
			$animsi.flip_h = true
			$animsi.play("run")
			linear_velocity.x = -speed
		else:
			$animsi.play("idle")
			linear_velocity.x = 0
	
		if jumping:
			if linear_velocity.y > 0:
				jumping = false
			elif not Input.is_action_pressed("up"):
				stop_jump = true
			
			if stop_jump:
				$Particles2D.emitting = false
				linear_velocity.y += jump_force * delta
		
		if not jumping and Input.is_action_pressed("up"):
			linear_velocity.y = -jump_velocity
			jumping = true
			stop_jump = false
			$Particles2D.emitting = true
			$animsi.play("jump")
		if (position.y > 600):
			is_down = true
			set_angular_velocity(2)
		position += linear_velocity * delta
		check_death()
	else:
		check_death()
		
func check_death():
	if (position.y > 1500):
		get_tree().change_scene("res://scene/End_game.tscn")
	elif (is_death==true):
		$animsi.play("death")
		$CollisionShape2D.disabled = true
		$Area2D/CollisionShape2D2.disabled = true
		if $animsi.get_frame() >= 32:
			get_tree().change_scene("res://scene/End_game.tscn")
			
func set_camera_limit():
	$Camera2D.limit_left = -2000
	$Camera2D.limit_right = 1500
	$Camera2D.limit_top = 538 / 2
	
func debug():
	print ($Camera2D.get_camera_position())

func check_change_scene():
	return is_change_scene
	
func _on_Coint_area_entered(area):
	is_change_scene=true

func _on_enemy_area_entered(area):
	is_death = true
	
func call_ball():
	shoot_time = 0
	var ball = Ball.instance()
	var ss = 1
	var pos = position + Vector2(-1, 1.0)
	ball.position = pos
	get_parent().add_child(ball)
	ball.linear_velocity = Vector2(100 * ss, -40)
	add_collision_exception_with(ball)
