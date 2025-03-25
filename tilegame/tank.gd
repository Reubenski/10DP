extends Area2D

@export var top_speed = 400
@export var acceleration = 4
@export var reload_time = 0.1
@export var projectile : PackedScene
var velocity = Vector2.ZERO
var screen_size
var reload_counter = 0;

func _ready():
	screen_size = get_viewport_rect().size
	var spawn = Vector2.ZERO
	spawn.x = screen_size.x/2
	spawn.y = screen_size.y-32
	position = spawn
	
func _process(delta):
	if Input.is_action_pressed("fire") and reload_counter <= 0:
		var p = projectile.instantiate()
		owner.add_child(p)
		p.transform = $Barrel.global_transform
		reload_counter = reload_time
	if reload_counter > 0:
		reload_counter -= delta
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
