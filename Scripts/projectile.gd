extends CharacterBody2D


var Speed = 400
var target
var pathName = ''
var damage = 1


func _physics_process(delta) -> void:

	#Get the input direction and handle the movement
	if is_instance_valid(target):
		velocity = global_position.direction_to(target.get_child(0).global_position) * Speed

		look_at(target.global_position)
		move_and_slide()
	if !is_instance_valid(target):
		queue_free()




func _on_area_2d_body_entered(body: Node2D) -> void:
	if 'Car' in body.name:
		#damage effect
		body.health-=damage
		#remove projectile
		queue_free()
	# Replace with function body.
	
