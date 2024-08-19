extends "res://Scripts/upgrade_button.gd"


# Called when the node enters the scene tree for the first time.
func _pressed():
	linked_tower.set_range(linked_tower.get_range()*1.5,true)
	purchase()
