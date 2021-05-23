extends Area2D


func _on_Coin_body_entered(body: Node) -> void:
	queue_free()
