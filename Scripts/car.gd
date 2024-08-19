extends CharacterBody2D

class_name Car

signal car_death
signal car_pass

var health: HealthComponent
var speed: SpeedComponent
var value: ValueComponent
var pos :Array[Vector2] 
var dead: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation = "drive_right"
	pos.append(global_position) 
	pos.append(global_position) 
	add_child(health)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	
	if !dead:
		pos[1] = global_position
		if pos[1].x - pos[0].x >0:
			$AnimatedSprite2D.play("drive_right")
		else:
			$AnimatedSprite2D.play("drive_left")
		pos[0] = pos[1]
		
		get_parent().set_progress(get_parent().get_progress() + speed.get_speed()*delta)

		if get_parent().get_progress_ratio() >= .95:
			death()
			dead=true
		if health.is_dead():
			death(true)

func initilize(health_component: HealthComponent,
			   speed_component: SpeedComponent,
			   value_component: ValueComponent,
			   on_death_cb: Callable, on_pass_cb: Callable):
	health = health_component
	speed = speed_component
	value = value_component
	car_death.connect(on_death_cb)
	car_pass.connect(on_pass_cb)

func take_damage(damage: float, _damage_type: String = 'PHYSICAL') -> void:
	if (_damage_type == "ICE")&&damage>0:
		var slow_time = ($SlowDownTimer.time_left+1) / ($SlowDownTimer.time_left)
		$SlowDownTimer.start(slow_time)
		speed.apply_slow(damage)
	elif (_damage_type == "FIRE")&&damage>0:
		health.burn(damage)
		$BurnTimer.start()
	else:
		health.take_damage(damage)

func _on_death_animation_done():
	get_parent().get_parent().queue_free()

func death(_killed:bool =false):
	dead = true
	$AnimatedSprite2D.animation_finished.connect(_on_death_animation_done)
	if _killed:
		car_death.emit(value)
		
	else:
		car_pass.emit()
	#get_parent().get_parent().queue_free()
	$AnimatedSprite2D.play("death2")
	

func _on_slow_down_timer_timeout() -> void:
	speed.restore_original_speed()
