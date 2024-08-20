extends Button

@export var linked_tower :RobotBase = null
@export var game_scene: TDLevel 
@export var upgrade_cost : ValueComponent = ValueComponent.new(25)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_scene = Global.level_choice
	#print(get_tree().get_root().get_node('UI').game_scene.gold.get_value())
	pass
	
	#game_scene = get_tree().game_scene

func set_link(tower: RobotBase) -> void:
	linked_tower = tower

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var can_afford: bool = game_scene.gold.can_afford(upgrade_cost)
	if (linked_tower == null)||linked_tower.upgrade_count>2:
		self.disabled = true
	elif  (can_afford==false):
		self.disabled = true
	else:
		upgrade_cost= linked_tower.upgrade_cost
		self.disabled = false
		
func purchase()->void:	
	game_scene.gold.spend_value(upgrade_cost)
