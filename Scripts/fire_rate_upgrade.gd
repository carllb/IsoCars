extends "res://Scripts/upgrade_button.gd"


# Called when the node enters the scene tree for the first time.
func _pressed():
	linked_tower.set_fire_rate(linked_tower.get_fire_rate()*1.25,true)
	purchase()
