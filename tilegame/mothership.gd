extends Area2D

@export var bomb : PackedScene
@export var bomb_time = 1
var bomb_counter = 0
@export var speed = 200
@export var uioffset=200
@export var square_size = 800
@export var ycenter = 100
@export var wave_height = 50
var screen_size
var screen_offset
var rng = RandomNumberGenerator.new()

func fire_effect():
	var fire_sound = load("res://art/Laser.wav")
	$AudioStreamPlayer.stream = fire_sound
	$AudioStreamPlayer.play()
	
func _ready():
	#screen_size = get_viewport_rect().size
	screen_size = Vector2(square_size +uioffset, square_size)
	screen_offset=Vector2(uioffset,0)
	bomb_counter = bomb_time + rng.randf_range(0, bomb_time)
	$AnimatedSprite2D.play()
	position.x = screen_size.x
	
func _process(delta):
	position.y = ycenter + sin(position.x/100)*wave_height
	position.x = position.x + speed*delta
	if (speed > 0 and position.x > screen_size.x) || (speed < 0 and position.x < uioffset):
		speed = - speed
	if bomb_counter <= 0:
		drop_bomb()
	bomb_counter -= delta
	
func drop_bomb():
	fire_effect()
	var p = bomb.instantiate()
	get_parent().add_child(p)
	p.transform = $BombDoors1.global_transform
	bomb_counter = bomb_time + rng.randf_range(0, bomb_time)
	
