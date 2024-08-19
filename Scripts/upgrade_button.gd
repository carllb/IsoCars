extends Button

var linked_tower :RobotBase = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_link(tower: RobotBase) -> void:
	linked_tower = tower

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (linked_tower == null)||linked_tower.upgrade_count>2:
		self.disabled = true
	else:
		self.disabled = false
