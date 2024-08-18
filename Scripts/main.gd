extends Node2D

class_name TDLevel

@export var mob_scene: PackedScene
@export var mob_path: PackedScene

@export_category("Debug Stuff")
@export var db_dot: Sprite2D

@onready
var tile_map: TileMapLayer = get_node("TileMapLayer")
var level_conf = parse_json("Config/level.json")

var score
var level = 0
var current_wave = []

func parse_json(path) -> Dictionary:
	var json_as_text = FileAccess.get_file_as_string(path)
	var json_as_dict = JSON.parse_string(json_as_text)
	return json_as_dict

func get_level():
	return level

var blank_texture: Texture2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MobTimer.start()


func wave_factory(level: int) -> Array:
	var ret = []
	# Have parsed all the available levels
	if len(level_conf["levels"]) <= level - 1:
		return ret
	
	var cur_level = level_conf["levels"][level-1]
	# Parse all of the available enenmies in the level
	for enemy in cur_level:
		# enemy may have multiple copies
		var copies = enemy["copies"]
		for _copy in range(copies):
			var health_comp = HealthComponent.new(enemy["health"], enemy["copies"])
			var speed_comp = SpeedComponent.new(enemy["speed"])
			# TODO:
			# var value
			# var type
			# var delay
			var car = car_factory(health_comp,speed_comp)
			ret.append(car)
	return ret

func car_factory(health_comp: HealthComponent, speed_comp: SpeedComponent) -> Car:
	var car: Car = mob_scene.instantiate()
	car.initilize(health_comp,speed_comp)

	return car

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func get_mob_count() -> int:
	var ret = 0
	for child in get_children():
		if child is Path2D:
			ret += 1
	return ret

func _on_mob_timer_timeout():

	# Current wave is empty
	if current_wave == [] and get_mob_count() == 0:
		level+=1
		current_wave = wave_factory(level)

	# There are cars left in the current wave
	else:
		if current_wave != []:
			# Create a new instance of the Mob scene.
			var path = mob_path.instantiate()
			# Get new car and add to scene
			var car = current_wave.pop_front()
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


#this is for debugging
#func update_pointer_position(pos: Vector2):
	#db_dot.position = pos
	
func build_normal_car(car):
	var health = 3
	var armor = 5
	var speed = 50
	var health_component: HealthComponent = HealthComponent.new(health, armor)
	var speed_component: SpeedComponent = SpeedComponent.new(speed)
	car.initilize(health_component, speed_component)
	
