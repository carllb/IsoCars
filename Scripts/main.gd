extends Node2D

class_name TDLevel

@export var mob_scene: PackedScene
@export var mob_path: PackedScene

@export_category("Debug Stuff")
@export var db_dot: Sprite2D

@onready
var tile_map: TileMapLayer = get_node("TileMapLayer")

var score

var blank_texture: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MobTimer.start()
	blank_texture = db_dot.texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var path = mob_path.instantiate()
	var car: Car = mob_scene.instantiate()
	var health_component: HealthComponent = HealthComponent.new(3, 5)
	car.initilize(health_component)
	path.get_child(0).add_child(car)
	add_child(path)

const placable_tiles: Array[Vector2i] = [Vector2i(0,3)]
var placed_tiles: Array[Vector2i] = []

func is_placable_tile(tile_coord: Vector2i) -> bool:
	var atlast_coord: Vector2i = tile_map.get_cell_atlas_coords(tile_coord)
	var valid_tile: bool = true
	if (!placable_tiles.has(atlast_coord)):
		valid_tile = false
		
	if (placed_tiles.has(tile_coord)):
		valid_tile = false
	
	return valid_tile

func update_pointer_position(pos: Vector2,
							 tower: RobotBase) -> bool:
	var tile_coord: Vector2i = tile_map.local_to_map(pos)
	var tile_pos: Vector2 = tile_map.map_to_local(tile_coord)
	db_dot.position = tile_pos
	var valid_tile: bool = is_placable_tile(tile_coord)
	
	if (null != tower):
		db_dot.texture = tower.get_sprite().texture
		db_dot.scale = tower.get_sprite().scale
		
		if valid_tile:
			db_dot.self_modulate.a = 1.0
		else:
			db_dot.self_modulate.a = 0.5
	else:
		db_dot.texture = blank_texture
		db_dot.self_modulate.a = 1.0
	
	return valid_tile

func map_clicked(pos: Vector2,
				 tower: RobotBase) -> bool:
	var tile_coord: Vector2i = tile_map.local_to_map(pos)
	var tile_pos: Vector2 = tile_map.map_to_local(tile_coord)
	
	var valid_tile: bool = is_placable_tile(tile_coord)
	
	if (valid_tile && null != tower):
		placed_tiles.append(tile_coord)
		tower.position = tile_pos
		add_child(tower)
	else:
		valid_tile = false
	
	return valid_tile
