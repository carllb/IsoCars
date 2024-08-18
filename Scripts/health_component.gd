extends Node2D
class_name HealthComponent

var health = 3
var armor = 0
var fire_resistance = 0

func take_damage() -> void:
	if armor > 0:
		armor -= 1
	else:
		health -= 1
	
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
