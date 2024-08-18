extends Node2D

class_name TDLevel

@export var mob_scene: PackedScene
@export var mob_path: PackedScene

@export_category("Debug Stuff")
@export var db_dot: Sprite2D

var score
var level = 0
var current_wave = []

func get_level():
	return level

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MobTimer.start()

func wave_factory(level: int) -> Array:
	#TODO: figure out wave loading for actually generating waves
	var ret = []
	for level_idx in range(level):
		var health_comp = HealthComponent.new(1, 1)
		var car = car_factory(health_comp)
		ret.append(car)
	return ret

func car_factory(health_comp: HealthComponent) -> Car:
	var car: Car = mob_scene.instantiate()
	var health_component: HealthComponent = health_comp
	car.initilize(health_component)

	return car

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var path = mob_path.instantiate()

	# Current wave is empty
	if current_wave == [] and path.get_child(0).get_child_count() == 0:
		level+=1
		current_wave = wave_factory(level)
		print(level)

	# There are cars left in the current wave
	else:
		# Get new car and add to scene
		var car = current_wave.pop_front()
		path.get_child(0).add_child(car)
		add_child(path)


#this is for debugging
func update_pointer_position(pos: Vector2):
	db_dot.position = pos
