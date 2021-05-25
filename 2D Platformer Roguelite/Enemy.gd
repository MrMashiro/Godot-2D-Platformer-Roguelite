class_name Enemy
extends KinematicBody2D
	
	
enum Direction {
	RIGHT = 1, 
	LEFT = -1 }
	
	
export (Direction) var direction = Direction.RIGHT
export (bool) var detects_cliffs = true
	
	
onready var animated_sprite = $AnimatedSprite
onready var collision_shape = $CollisionShape2D
onready var floor_checker = $FloorChecker
	
	
var velocity = Vector2.ZERO
	
	
func _ready() -> void:
	if direction == Direction.RIGHT:
		animated_sprite.flip_h = true
	floor_checker.position.x = collision_shape.shape.get_extents().x * direction
	floor_checker.enabled = detects_cliffs
	
	
func _physics_process(delta: float) -> void:
	if is_on_wall() or not floor_checker.is_colliding() and detects_cliffs and is_on_floor():
		direction *= Direction.LEFT
		animated_sprite.flip_h = not animated_sprite.flip_h
		floor_checker.position.x = collision_shape.shape.get_extents().x * direction
	
	
	velocity.y += 20
	velocity.x = 50 * direction
	
	velocity = move_and_slide(velocity, Vector2.UP)
	
