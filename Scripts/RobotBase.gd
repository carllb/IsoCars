extends Node2D

class_name RobotBase

var projectile 
var rangeRadius
var damage_array: Array[int] = [1,0,0] 
var pathName
var targets = []
var activeTarget
var fire_rate : float =2
var sprites = [preload("res://assets/temporary/up-left.png"),preload("res://assets/temporary/down-left.png")
		,preload("res://assets/temporary/down-right.png"),preload("res://assets/temporary/up-right.png")]


func _init(_damage: Array[int] = damage_array, _projectile = preload('res://Scenes/Projectile.tscn'), _range_size:int = 200) -> void:
	rangeRadius = _range_size
	damage_array = _damage
	projectile = _projectile
	
func initilize(_damage: Array[int] = damage_array, _sprites = sprites,_projectile = preload('res://Scenes/Projectile.tscn'), _range_size:int = 200) -> void:
	rangeRadius = _range_size
	damage_array = _damage
	sprites = _sprites
	projectile = _projectile

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_instance_valid(activeTarget):
		if activeTarget.rotation > PI/2:
			$Sprite2D.texture = sprites[0]
		elif activeTarget.rotation > 0:
			$Sprite2D.texture = sprites[1]
		elif activeTarget.rotation > -PI/2:
			$Sprite2D.texture = sprites[2]
		else:
			$Sprite2D.texture = sprites[3]


func _on_range_2d_body_entered(body: Node2D) -> void:
	if "Car" in body.name:
		find_target(body)

func _on_range_2d_body_exited(body: Node2D) -> void:
	find_target(body)

func find_target(body: Node2D):

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
		find_target($Range2D)
		if activeTarget == null:
			$ShotTimer.stop()


func get_sprite() -> Sprite2D:
	return get_node("Sprite2D")

func get_value() -> int:
	return 0
