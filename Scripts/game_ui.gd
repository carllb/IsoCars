extends Control

@export_category("Mouse Input Scaling")
@export var game_texture: TextureRect
@export var game_viewport: SubViewport

@export var game_scene: TDLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mpos: Vector2 = game_viewport.get_mouse_position()
	game_scene.update_pointer_position(mpos)
	
	var levelLabel : Label = get_node("MainPanel/VerticalContainer/Top Bar/Level")
	levelLabel.text = "Level: " + str(game_scene.get_level())
