extends Node2D

class_name TDLevel

@export var mob_scene: PackedScene
@export var mob_path: PackedScene

@export_category("Debug Stuff")
@export var db_dot: Sprite2D

var score


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MobTimer.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var path = mob_path.instantiate()
	var car: Car = mob_scene.instantiate()
	build_normal_car(car)
	path.get_child(0).add_child(car)
	add_child(path)
	car.take_damage(75, "ICE")


#this is for debugging
func update_pointer_position(pos: Vector2):
	db_dot.position = pos
	
func build_normal_car(car):
	var health = 3
	var armor = 5
	var speed = 50
	var health_component: HealthComponent = HealthComponent.new(health, armor)
	var speed_component: SpeedComponent = SpeedComponent.new(speed)
	car.initilize(health_component, speed_component)
	
