extends CharacterBody2D

class_name Car

@export var speed = 50

var health: HealthComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation = "drive"
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$AnimatedSprite2D.play()
	
	get_parent().set_progress(get_parent().get_progress() + speed*delta)

	if get_parent().get_progress_ratio() >= .95:
		death()
	if health.is_dead():
		death()

func initilize(health_component):
	health = health_component

func take_damage(damage: float) -> void:
	health.take_damage(damage)

func death():
	get_parent().get_parent().queue_free()
