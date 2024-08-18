
extends RobotBase


##set sprites
#sprites = [upleft,downleft,downright,upright]
##[phys,fire,ice]

func _init(_range_size:int = 200, _damage: Array[int] = [0,0,40], _projectile = preload('res://Scenes/Projectile.tscn'),
			 _fire_rate:float =0.1) -> void:
	rangeRadius = _range_size
	damage_array = _damage
	projectile = _projectile
	#$ShotTimer.set_wait_time(1/_fire_rate)
