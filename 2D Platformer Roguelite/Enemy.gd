class_name Enemy
extends KinematicBody2D
	
	
enum Direction {
	RIGHT = 1, 
	LEFT = -1 }
	
	
export (Direction) var direction = Direction.RIGHT
export (bool) var detects_cliffs = true
export (Color) var color = Color.white setget set_color
	
	
onready var animated_sprite = $AnimatedSprite
onready var collision_shape = $CollisionShape2D
onready var floor_checker = $FloorChecker
onready var top_checker = $TopChecker
onready var sides_checker = $SidesChecker
onready var timer = $Timer
	
	
var speed := 50.0 
var velocity = Vector2.ZERO
	
	
func _ready() -> void:
	if direction == Direction.RIGHT:
		animated_sprite.flip_h = true
	floor_checker.position.x = collision_shape.shape.get_extents().x * direction
	floor_checker.enabled = detects_cliffs
#	if detects_cliffs:
#		set_modulate(Color(1.2, 0.5, 1))
	
	
func _physics_process(delta: float) -> void:
	if is_on_wall() or not floor_checker.is_colliding() and detects_cliffs and is_on_floor():
		direction *= Direction.LEFT
		animated_sprite.flip_h = not animated_sprite.flip_h
		floor_checker.position.x = collision_shape.shape.get_extents().x * direction
	velocity.y += 20
	velocity.x = speed * direction
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
func set_color(var new_value):
	set_modulate(new_value)
	
	
func _on_TopChecker_body_entered(body: Node) -> void:
	animated_sprite.play("squashed")
	speed = 0
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0, false)
	top_checker.set_collision_layer_bit(4, false)
	top_checker.set_collision_mask_bit(0, false)
	sides_checker.set_collision_mask_bit(0, false)
	timer.start()
	body.bounce()
	
	
func _on_SidesChecker_body_entered(body: Node) -> void:
	body.hit(position.x)
	
	
func _on_Timer_timeout() -> void:
	queue_free()
