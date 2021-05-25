class_name Player
extends KinematicBody2D

export var gravity := 75
export (float, 1, 10, 0.1) var player_speed := 4.0
export (float, -30, -1, 0.1) var jump_force := -18

onready var player_sprite = $Sprite
onready var timer = $Timer

const GRAVITY_ON_FLOOR = 10
const SPRITES = ["idle", "happy"]

var velocity := Vector2.ZERO
var idle_animated_sprites = SPRITES
var rand_idle_sprites
var coins := 0

"""
Better Jump - https://www.youtube.com/watch?v=hG9SzQxaCm8
// Calculate the gravity and initial jump velocity values 
_jumpGravity = -(2 * JumpHeight) / Mathf.Pow(TimeToJumpHeight , 2);
_jumpVelocity = Mathf.Abs(_jumpGravity) * TimeToJumpHeight ;

// Step update
stepMovement = (_velocity + Vector3.up * _gravity * Time.deltaTime * 0.5f) * Time.deltaTime;
transform.Translate(stepMovement);
_velocity.y += _gravity * Time.deltaTime;

// When jump button pressed,
_velocity.y = _jumpVelocity;

---------
https://pastebin.com/pFJ23HXP
Vy = H*Vx / X
G = -0.5*H*Vx^2 / X^2

Vy = initial jump speed
H = maximum height
Vx = maximum horizontal speed
X = maximum jump width
G = gravity
/ = division
^2 = square
"""
	
	
func _ready() -> void:
	randomize()
	rand_idle_sprites = idle_animated_sprites[randi() % idle_animated_sprites.size()]
	
	
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
#		print(is_on_floor())
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force * 100.0
	
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, 0, 0.5)
	velocity.y += gravity
	
	
func _gravity() -> void:
	if is_on_floor():   
		velocity.y = GRAVITY_ON_FLOOR
	else:
		velocity.y += gravity         
	
	
func _on_FallZone_body_entered(body: Node) -> void:
	if body == self:
		get_tree().change_scene("res://Level1.tscn")
#		print(body.name, " ", body.get_children().size())
	
""""
	if body == Enemy:
		print(body.name, " ", body.get_children().size())
		body.queue_free()
"""
	
	
func bounce() -> void:
	velocity.y = ((jump_force * 100.0) * 0.7)
	
	
func hit(var enemy_posX) -> void:
	set_modulate(Color(1,0.3,0.3,0.3))
	velocity.y = ((jump_force * 100.0) * 0.5)
	
	if position.x < enemy_posX:
		velocity.x = -1000
	elif position.x > enemy_posX:
		velocity.x = 1000
		
	Input.action_release("left")
	Input.action_release("right")
	timer.start()
	
	
func _on_Timer_timeout() -> void:
	print("You lose !")
	get_tree().change_scene("res://TitleMenu.tscn")
	
