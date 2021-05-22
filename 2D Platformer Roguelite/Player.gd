class_name Player
extends KinematicBody2D

export var gravity := 75
export (float, 1, 10, 0.1) var player_speed := 3.8
export (float, -20, -1, 0.1) var jump_force := -19

onready var player_sprite = $Sprite

const GRAVITY_ON_FLOOR = 10

var velocity := Vector2.ZERO
var animated_sprites = ["idle", "happy"]
var rand_idle_sprites


func _ready() -> void:
	randomize()
	rand_idle_sprites = animated_sprites[randi() % 2]


func _physics_process(_delta: float) -> void:
	_gravity()
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
	
#	print(is_on_floor())
	
	velocity.y += gravity
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force * 100.0
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
	velocity.x = lerp(velocity.x, 0, 0.5)


func _gravity():
	if is_on_floor():   velocity.y = GRAVITY_ON_FLOOR
	else:               velocity.y += gravity


func _on_FallZone_body_entered(body: Node) -> void:
	if body == self:
		var _err = get_tree().change_scene("res://Level1.tscn")
#		print(body.name, " ", body.get_children().size())
#	if body == Enemy:
#		print(body.name, " ", body.get_children().size())
#		body.queue_free()
