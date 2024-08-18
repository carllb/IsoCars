extends CharacterBody2D

class_name Car


var health: HealthComponent
var speed: SpeedComponent

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation = "drive"
	add_child(health)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$AnimatedSprite2D.play()
	#print(speed.get_speed())
	
	get_parent().set_progress(get_parent().get_progress() + speed.get_speed()*delta)

	if get_parent().get_progress_ratio() >= .95:
		death()
	if health.is_dead():
		death()

func initilize(health_component, speed_component):
	health = health_component
	speed = speed_component

func take_damage(damage: float, damage_type: String) -> void:
	if damage_type == "ICE":
		$SlowDownTimer.start()
		speed.apply_slow(damage)
	else:
		health.take_damage(damage)
	
func death():
	get_parent().get_parent().queue_free()

func _on_slow_down_timer_timeout() -> void:
	speed.restore_original_speed()
