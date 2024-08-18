extends Node2D

class_name SpeedComponent

var speed = 0
var slowed = false
var slowed_speed = 0

func _init(speed_val: float):
	speed = speed_val

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func apply_slow(slowdown_percent: float):
	slowed = true
	slowed_speed = speed * (1 - (slowdown_percent / 100))

	
func get_speed():
	if slowed:
		return slowed_speed
	return speed
	
func restore_original_speed():
	slowed = false
