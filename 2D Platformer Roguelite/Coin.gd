class_name Coin
extends Area2D

signal coin_collected 


onready var animation_player = $AnimationPlayer


var signal_counter := 1


func _on_Coin_body_entered(body: Node) -> void:
	animation_player.play("bounce")
	if signal_counter > 0:
		emit_signal("coin_collected")
		set_collision_mask_bit(0, false)
		signal_counter -= 1


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	queue_free()
