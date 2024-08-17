extends CharacterBody2D

class_name Car

@export var speed = 400
var path: PathFollow2D
var health = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$AnimatedSprite2D.animation = "drive"
	$AnimatedSprite2D.play()
	path.set_progress(path.get_progress() + speed*delta)
		
	if path.get_progress_ratio() == 1:
		death()
	
func _on_body_entered(_body: Node) -> void:
	health -= 1
	
func death():
	path.get_parent().queue_free()

	
