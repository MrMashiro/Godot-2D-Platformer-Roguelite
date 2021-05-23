extends Area2D


onready var animation_player = $AnimationPlayer


func _on_Coin_body_entered(body: Node) -> void:
	animation_player.play("bounce")
	body.add_coin()


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	queue_free()
