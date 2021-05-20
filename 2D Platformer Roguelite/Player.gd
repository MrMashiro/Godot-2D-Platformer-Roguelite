class_name Player
extends KinematicBody2D

export var gravity := 100
export (float, 1, 10, 0.1) var player_speed := 3.8
export (float, -20, -1, 0.1) var jump_force := -13.5

var velocity := Vector2.ZERO

func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("right"):
		velocity.x = player_speed * 100.0
	if Input.is_action_pressed("left"):
		velocity.x = -player_speed * 100.0
	
	velocity.y += gravity
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force * 100.0
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x, 0, 0.5)
