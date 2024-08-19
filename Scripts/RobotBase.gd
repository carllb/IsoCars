extends Node2D

class_name RobotBase

signal clicked(node)

var projectile 
var rangeRadius
var damage_array: Array[int] = [1,0,0] 
var pathName
var targets = []
var upgrade_count :int = 0
var activeTarget
var fire_rate : float =2
var sprites = [preload("res://assets/sprites/up-left.png"),preload("res://assets/sprites/up-right.png")]
func _init(_damage: Array[int] = damage_array, _projectile = preload('res://Scenes/Projectile.tscn'), _range_size:int = 200) -> void:
	rangeRadius = _range_size
	damage_array = _damage
	projectile = _projectile
	
func initilize(_damage: Array[int] = damage_array, _sprites = sprites,
		_projectile = preload('res://Scenes/Projectile.tscn'), _range_size:int = 200) -> void:
	rangeRadius = _range_size
	damage_array = _damage
	sprites = _sprites
	$Sprite2D.texture = sprites[0]
	projectile = _projectile
	$ShotTimer.set_wait_time(1/fire_rate)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_instance_valid(activeTarget):
		if activeTarget.rotation > 0:
			$Sprite2D.texture = sprites[0]
		else:
			$Sprite2D.texture = sprites[1]
	$Sprite2D.scale = Vector2(0.8+0.2*upgrade_count,0.8+0.2*upgrade_count)
	$TowerArea.scale = Vector2(4+1*upgrade_count,4+1*upgrade_count)
	


func _on_range_2d_body_entered(body: Node2D) -> void:
	if "Car" in body.name:
		find_target()

func _on_range_2d_body_exited() -> void:
	find_target()

func find_target():

	$ShotTimer.start()
	
	
	var tempArray = []
	#gets all nodes with collision in range
	targets = get_node('Range2D').get_overlapping_bodies()
	#gets cars in range
	for i in targets:
		if 'Car' in i.name:
			tempArray.append(i)
			
	activeTarget = null
	
	#sets target to most progress
	for i in tempArray:
		if activeTarget == null:
			activeTarget = i.get_node('../')
			pathName = activeTarget.get_parent().name
		else:
			if i.get_parent().get_progress() > activeTarget.get_progress():
				activeTarget = i.get_node('../')
				pathName = activeTarget.get_parent().name



func _on_timer_timeout() -> void:
	if activeTarget != null:
		var tempProjectile = projectile.instantiate()
		tempProjectile.initilize(250, damage_array,activeTarget, pathName)
		await get_tree().process_frame
		get_node('ProjectileDisconect').add_child(tempProjectile)
		tempProjectile.global_position = $TowerArea.global_position
	else:
		find_target()
		if activeTarget == null:
			$ShotTimer.stop()



func get_fire_rate() -> float:
	return fire_rate
	
func get_range() -> float:
	return rangeRadius

func get_damage() -> Array[int]:
	return damage_array

func set_fire_rate(new_rate) -> void:
	fire_rate = new_rate
	$ShotTimer.set_wait_time(1/fire_rate)
	upgrade_count+=1
	
func set_range(new_range) -> void:
	rangeRadius = new_range
	upgrade_count+=1

func set_damage(new_damage) -> void:
	damage_array = new_damage
	upgrade_count+=1
	
func get_sprite() -> Sprite2D:
	return get_node("Sprite2D")

func get_value() -> int:
	return 0

var mouse_in = false
