extends Area2D

@export var top_speed = 400
@export var acceleration = 4
var velocity = Vector2.ZERO
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	var spawn = Vector2.ZERO
	spawn.x = screen_size.x/2
	spawn.y = screen_size.y-32
	position = spawn
	
func _process(delta):
	if Input.is_action_pressed("right"):
		velocity.x += acceleration
	elif velocity.x > 0:
		velocity.x -= acceleration
	if Input.is_action_pressed("left"):
		velocity.x -= acceleration
	elif velocity.x < 0:
		velocity.x += acceleration
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
