extends "res://Scripts/upgrade_button.gd"


# Called when the node enters the scene tree for the first time.
func _pressed():
	linked_tower.set_damage([0,0,linked_tower.get_damage()[2]+5])
