extends CharacterBody2D


var Speed = 300.0
var target
var pathName = ''
var damage


func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement
	var pathSpawnerNode = get_tree().get_root().get_node('Main/PathSpawner')
	for i in pathSpawnerNode.get_child_count():
		if pathSpawnerNode.get_child(i).name == pathName:
			target = pathSpawnerNode.get_child(i).get_child(0).get_child(0).global_position
			
	velocity = global_position.direction_to(target) * Speed

	look_at(target)
	move_and_slide()



func _on_area_2d_body_entered(body: Node2D) -> void:
	if 'car' in body.name:
		#damage effect
		
		#remove projectile
		queue_free()
	pass # Replace with function body.
