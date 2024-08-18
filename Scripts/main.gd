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
	add_child(path)

	
#this is for debugging
func update_pointer_position(pos: Vector2):
	db_dot.position = pos