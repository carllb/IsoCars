extends RigidBody2D

@export var speed = 400
var screen_size
signal hit
var health = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2(1, 0)
	velocity = velocity.normalized() * speed
	$AnimatedSprite2D.animation = "drive"
	$AnimatedSprite2D.play()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)


func _on_body_entered(body: Node) -> void:
	health -= 1
	

func start(pos):
	position = pos
