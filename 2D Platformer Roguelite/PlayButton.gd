extends Button


func _on_PlayButton_pressed() -> void:
	get_tree().change_scene("res://Level1.tscn")


func _on_QuitButton_pressed() -> void:
	get_tree().quit()
