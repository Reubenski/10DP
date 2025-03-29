extends Area2D

@export var top_speed = 400
@export var acceleration = 300
@export var reload_time = 1
@export var projectile : PackedScene
@export var uioffset=200
@export var square_size = 800
var velocity = Vector2.ZERO
var screen_size
var screen_offset
var reload_counter = 0;


func _ready():
	screen_size = Vector2(square_size  +uioffset, square_size)
	screen_offset=Vector2(uioffset,0)
	var spawn = Vector2.ZERO
	spawn.x = uioffset + screen_size.x/2
	spawn.y = screen_size.y-32
	position = spawn
	$AnimatedSprite2D.play()
	
func _process(delta):
	if Input.is_action_pressed("fire") and reload_counter <= 0:
		var p = projectile.instantiate()
		owner.add_child(p)
		p.transform = $Barrel.global_transform
		reload_counter = reload_time
	if reload_counter > 0:
		reload_counter -= delta
	if Input.is_action_pressed("right"):
		velocity.x += acceleration * delta
	elif velocity.x > 0:
		velocity.x -= acceleration * delta
	if Input.is_action_pressed("left"):
		velocity.x -= acceleration * delta
	elif velocity.x < 0:
		velocity.x += acceleration * delta
	position += velocity * delta
	position = position.clamp(screen_offset, screen_size)
