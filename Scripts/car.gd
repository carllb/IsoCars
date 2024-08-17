extends CharacterBody2D

@export var speed = 400
var health = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$AnimatedSprite2D.animation = "drive"
	$AnimatedSprite2D.play()
	get_parent().set_progress(get_parent().get_progress() + speed*delta)
	
	if get_parent().get_progress_ratio() == 1:
		death()
	
func _on_body_entered(body: Node) -> void:
	health -= 1
	
func death():
	get_parent().get_parent().queue_free()
