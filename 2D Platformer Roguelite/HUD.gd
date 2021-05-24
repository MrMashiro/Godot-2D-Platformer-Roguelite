extends CanvasLayer

onready var coins_count = $x

var coins := 0

func _ready() -> void:
	coins_count.text = str(coins)


func _physics_process(delta: float) -> void:
	if coins == 3:
		get_tree().change_scene("res://Level1.tscn")	
#		print("GG ! - You have collected: ", coins, " coins")


func _on_coin_collected() -> void:
	coins += 1
	_ready()
