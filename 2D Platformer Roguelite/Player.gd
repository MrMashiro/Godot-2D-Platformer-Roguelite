class_name Player
extends KinematicBody2D

export var gravity := 100
export (float, 1, 10, 0.1) var player_speed := 3.8
export (float, -20, -1, 0.1) var jump_force := -13.5

onready var player_sprite = $Sprite

var velocity := Vector2.ZERO
var animated_sprites = ["idle", "happy"]
var rand_idle_sprites

func _ready() -> void:
	randomize()
	rand_idle_sprites = animated_sprites[randi() % 2]

func _physics_process(_delta: float) -> void:
	player_movement()

func player_movement()-> void:
	if Input.is_action_pressed("right"):
		velocity.x = player_speed * 100.0
		player_sprite.play("walk")
		player_sprite.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -player_speed * 100.0
		player_sprite.play("walk")
		player_sprite.flip_h = true
	else:
		player_sprite.play(rand_idle_sprites)
		
	if not is_on_floor():
		player_sprite.play("air")
	
	velocity.y += gravity
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force * 100.0
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x, 0, 0.5)
