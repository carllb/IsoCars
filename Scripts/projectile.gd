extends CharacterBody2D

class_name Projectile

var Speed : int
var target : Node2D
var pathName = ''
var damage_array : Array[int]
var damage_types : Array[String] = ['PHYSICAL','FIRE','ICE']
var sprite = preload("res://assets/temporary/fire.png")

func initilize(_damage_array: Array[int] = [1,0,0], _target : Node2D = null,
 					_pathName: String = '',_speed: int = 600) -> void:
	$Sprite2D.texture = sprite
	Speed = _speed
	damage_array = _damage_array
	target = _target
	pathName = _pathName

func _physics_process(_delta) -> void:

	#Get the input direction and handle the movement
	if is_instance_valid(target):
		velocity = global_position.direction_to(target.get_child(0).global_position) * Speed

		look_at(target.global_position)
		move_and_slide()
	if !is_instance_valid(target):
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Car:
		var car: Car = body
		
		#apply damage
		for d in range(damage_array.size()):
			car.take_damage(damage_array[d],damage_types[d])

		#remove projectile
		queue_free()
