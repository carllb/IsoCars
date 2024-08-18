extends Node2D
class_name HealthComponent

var health = 10
var armor = 0
var BurnTimer :Timer = Timer.new()
var fire_time = 0
var fire_resistance = 0
var freeze_resistance = 0

func _init(start_health: float, _start_armor: float):
	health = start_health
	add_child(BurnTimer)
	BurnTimer.set_wait_time(0.5)
	BurnTimer.one_shot = true
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

func burn(damage: float):
	fire_time+=damage
	BurnTimer.start()

func is_dead() -> bool:
	return (0 >= health)
	
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	await BurnTimer.timeout
	if fire_time > 0:
		take_damage(fire_time - fire_resistance)
		fire_time -= 1
		if fire_time > 0:
			BurnTimer.set_wait_time(0.5)
			BurnTimer.start()
