
extends RobotBase


##set sprites
#sprites = [upleft,downleft,downright,upright]
##[phys,fire,ice]

func _init(_range_size:int = 200, _damage: Array[int] = [0,3,0], _projectile = preload('res://Scenes/Projectile.tscn')) -> void:
	rangeRadius = _range_size
	damage_array = _damage
	projectile = _projectile
