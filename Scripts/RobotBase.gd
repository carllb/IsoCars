extends Node2D

class_name RobotBase

var projectile 
var rangeRadius
var damage_array 
var pathName
var targets = []
var activeTarget


func _init(_range_size:int = 200, _damage: Array[int] = [1,0,0], _projectile = preload('res://Scenes/Projectile.tscn')) -> void:
	rangeRadius = _range_size
	damage_array = _damage
	projectile = _projectile
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_instance_valid(activeTarget):
		if activeTarget.rotation > PI/2:
			$Sprite2D.texture = load("res://assets/temporary/up-left.png")
		elif activeTarget.rotation > 0:
			$Sprite2D.texture = load("res://assets/temporary/down-left.png")
		elif activeTarget.rotation > -PI/2:
			$Sprite2D.texture = load("res://assets/temporary/down-right.png")
		else:
			$Sprite2D.texture = load("res://assets/temporary/up-right.png")


func _on_range_2d_body_entered(body: Node2D) -> void:
	if 'Car' in body.name:
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
			else:
				if i.get_parent().get_progress() > activeTarget.get_progress():
					activeTarget = i.get_node('../')
					
		pathName = activeTarget.get_parent().name
		#spawns projectile toward enemy

func _on_range_2d_body_exited(body: Node2D) -> void:
	if 'Car' in body.name:
		targets = get_node('Range2D').get_overlapping_bodies()
		activeTarget = null
		var tempArray = []
		for i in targets:
			if 'Car' in i.name:
				tempArray.append(i)
		#sets target to most progress
		for i in tempArray:
			if activeTarget == null:
				activeTarget = i.get_node('../')
			else:
				if i.get_parent().get_progress() > activeTarget.get_progress():
					activeTarget = i.get_node('../')

func _on_timer_timeout() -> void:
	if activeTarget != null:
		var tempProjectile = projectile.instantiate()
		tempProjectile.initilize(400, damage_array,activeTarget, pathName)
		await get_tree().process_frame
		get_node('ProjectileDisconect').add_child(tempProjectile)
		tempProjectile.target = activeTarget
		tempProjectile.global_position = $TowerArea.global_position

func get_sprite() -> Sprite2D:
	return get_node("Sprite2D")
