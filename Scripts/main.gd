extends Node2D

@export var mob_scene: PackedScene
@export var mob_path: PackedScene
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
