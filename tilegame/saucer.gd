extends Area2D

@export var bomb : PackedScene
@export var bomb_time = 2
var bomb_counter = 0
@export var speed = 200
@export var drop_distance = 128
@export var margins = 100
@export var uioffset=200
@export var square_size = 800
var target_y = drop_distance
var screen_size
var screen_offset
var rng = RandomNumberGenerator.new()

func _ready():
	#screen_size = get_viewport_rect().size
	screen_size = Vector2(square_size +uioffset, square_size)
	screen_offset=Vector2(uioffset,0)
	bomb_counter = bomb_time + rng.randf_range(0, bomb_time)
	$AnimatedSprite2D.play()
	
func _process(delta):
	if position.y < target_y:
		position.y += abs(speed) * delta
		return
	if (speed > 0 and position.x > (screen_size.x)- margins ) || (speed < 0 and position.x < (margins + uioffset)):
		speed = -speed
		target_y = min(target_y+drop_distance,screen_size.y/2)
	position.x += speed * delta
	position = position.clamp(screen_offset, screen_size)
	if bomb_counter <= 0:
		drop_bomb()
	bomb_counter -= delta
	
func drop_bomb():
	var p = bomb.instantiate()
	get_parent().add_child(p)
	p.transform = $BombDoors.global_transform
	bomb_counter = bomb_time + rng.randf_range(0, bomb_time)
	
