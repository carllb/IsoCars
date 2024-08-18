extends Control

@export_category("Mouse Input Scaling")
@export var game_texture: TextureRect
@export var game_viewport: SubViewport = get_viewport()

@export var game_scene: TDLevel

var current_tower: RobotBase = null
var curr_tower_cost: ValueComponent = null

@onready var levelLabel : Label = get_node("MainPanel/VerticalContainer/Top Bar/Level")
@onready var moneyLabel : Label = get_node("MainPanel/VerticalContainer/Top Bar/Money")
@onready var spentLabel : Label = get_node("MainPanel/VerticalContainer/Top Bar/MoneySpent")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func clear_selected_tower():
	if (null != current_tower):
		current_tower.queue_free()
	current_tower = null
	curr_tower_cost = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mpos: Vector2 = game_viewport.get_mouse_position()
	game_scene.update_pointer_position(mpos, current_tower)
	
	levelLabel.text = "Level: " + str(game_scene.get_level())
	moneyLabel.text = str(game_scene.get_money().get_value()) + " gold"
	spentLabel.text = "Total Spent: " + str(game_scene.get_money_spent().get_value()) + " gold"
	
	game_scene.update_pointer_position(mpos, current_tower)

func _on_add_tower_pressed(tower: PackedScene, cost: ValueComponent):
	var can_afford: bool = game_scene.get_money().can_afford(cost)
	
	clear_selected_tower()

	if (can_afford):
		current_tower = tower.instantiate()
		curr_tower_cost = cost


func _on_sub_viewport_container_gui_input(event: InputEvent):
	var pressed: bool = false
	var alt_pressed: bool = false
	if event is InputEventMouseButton:
		if event.pressed == true:
			print(event.button_index)
			if event.button_index == 1:
				pressed = true
			elif event.button_index == 2:
				alt_pressed = true
	
	if pressed:
		var mpos: Vector2 = game_viewport.get_mouse_position()
		var placed: bool = game_scene.map_clicked(mpos, 
												  current_tower,
												  curr_tower_cost)
		if placed:
			print("placed")
			current_tower = null
	elif alt_pressed:
		clear_selected_tower()
