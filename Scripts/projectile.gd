extends CharacterBody2D


var Speed = 400
var target
var pathName = ''
var damage = 1


func _physics_process(delta) -> void:

	#Get the input direction and handle the movement
	velocity = global_position.direction_to(target.get_child(0).global_position) * Speed

	look_at(target.global_position)
	move_and_slide()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if 'car' in body.name:
		#damage effect
		
		#remove projectile
		queue_free()
	pass # Replace with function body.
