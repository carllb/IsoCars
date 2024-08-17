extends Node2D

@export var mob_scene: PackedScene
@export var mob_path: PathFollow2D
var score


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MobTimer.start()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob: Car = mob_scene.instantiate()	
	mob.path = mob_path

	# Spawn the mob by adding it to the Main scene.
	mob_path.add_child(mob)
