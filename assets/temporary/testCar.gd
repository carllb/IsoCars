extends CharacterBody2D

var speed = 200



func _process(delta):
	get_parent().set_progress(get_parent().get_progress() + speed*delta)
