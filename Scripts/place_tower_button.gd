extends Button

signal add_tower_pressed

@export var tower_scene: PackedScene
@export var tower_cost: int


func _pressed():
	var vc: ValueComponent = ValueComponent.new(tower_cost)
	add_tower_pressed.emit(tower_scene, vc)
