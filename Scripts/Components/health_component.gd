extends Node2D
class_name HealthComponent

var health = 10
var armor = 0
var fire_resistance = 0
var freeze_resistance = 0

func _init(start_health: float, _start_armor: float):
	health = start_health
	if _start_armor:
		armor = _start_armor

func take_damage(damage: float) -> void:
	var rem = damage - armor
	
	if armor > 0:
		armor -= damage
	
	if armor < 0:
		armor = 0
	
	if rem > 0:
		health -= rem

func is_dead() -> bool:
	return (0 >= health)
	
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
