class_name TowerLinkedLabel 
extends Label


@export var linked_tower :RobotBase = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if linked_tower == null:
		text = 'No Robot\nSelected'
	elif linked_tower.get_upgrades() >=3 :
		text = 'Robot at\nMax Upgrades'
	else:
		text = 'Upgrade Cost\n'+str(linked_tower.upgrade_cost.get_value())+' gold'



func set_link(tower: RobotBase) -> void:
	linked_tower = tower
