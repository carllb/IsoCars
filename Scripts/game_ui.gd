extends Control

@export_category("Mouse Input Scaling")
@export var game_texture: TextureRect
@export var game_viewport: SubViewport

@export var game_scene: TDLevel

var current_tower: RobotBase = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mpos: Vector2 = game_viewport.get_mouse_position()
	
	game_scene.update_pointer_position(mpos, current_tower)

func _on_add_tower_pressed(tower: PackedScene):
	if (null != current_tower):
		current_tower.queue_free()

	current_tower = tower.instantiate()


func _on_sub_viewport_container_gui_input(event: InputEvent):
	var pressed: bool = false
	if event is InputEventMouseButton:
		if event.button_index == 1:
			if event.pressed == true:
				pressed = true
	
	if pressed:
		var mpos: Vector2 = game_viewport.get_mouse_position()
		var placed: bool = game_scene.map_clicked(mpos, current_tower)
		
		if placed:
			print("placed")
			current_tower = null
