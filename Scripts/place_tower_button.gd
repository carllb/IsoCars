extends Button

signal add_tower_pressed

@export var tower_scene: PackedScene
@export var tower_cost: int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _pressed():
	var vc: ValueComponent = ValueComponent.new(tower_cost)
	add_tower_pressed.emit(tower_scene, vc)
