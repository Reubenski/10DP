extends Area2D

@export var speed = 400
@export var drop_distance = 128
@export var margins = 100
var target_y = drop_distance
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	
func _process(delta):
	if position.y < target_y:
		position.y += abs(speed) * delta
		return
	if (speed > 0 and position.x > screen_size.x - margins) || (speed < 0 and position.x < margins):
		speed = -speed
		target_y = min(target_y+drop_distance,screen_size.y/2)
	position.x += speed * delta
	position = position.clamp(Vector2.ZERO, screen_size)
