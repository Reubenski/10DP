extends Area2D

@export var top_speed = 400
@export var acceleration = 250
@export var health = 1
@export var missile_speed = 400
@export var missile_size = 1
@export var reload_pattern = [1]
@export var projectile : PackedScene
@export var projectile_count = 1
@export var uioffset=200
@export var square_size = 800
@export var penetrating_bullets = false
@export var homing_missiles = false
var velocity = Vector2.ZERO
var screen_size
var screen_offset
var reload_counter = 0;
var reload_position = 0;


func _ready():
	screen_size = Vector2(square_size  +uioffset, square_size)
	screen_offset=Vector2(uioffset,0)
	var spawn = Vector2.ZERO
	spawn.x = uioffset + screen_size.x/2
	spawn.y = screen_size.y-32
	position = spawn
	$AnimatedSprite2D.play()
	
func fire_effect():
	var fire_sound = load("res://art/2699.mp3")
	$AudioStreamPlayer.stream = fire_sound
	$AudioStreamPlayer.play()

func _process(delta):
	if Input.is_action_pressed("fire") and reload_counter <= 0:
		fire_effect()
		for n in range(projectile_count):
			var p = projectile.instantiate()
			owner.add_child(p)
			p.transform = $Barrel.global_transform
			p.xspeed = (-(projectile_count-1)/2 + n)*100 #magic number cause I'm a hack
			p.penetrating = penetrating_bullets
			p.homing = homing_missiles
			p.speed = missile_speed
			p.scale.x = missile_size
			p.scale.y = missile_size
		reload_counter = reload_pattern[reload_position]
		reload_position = reload_position + 1
		if reload_position >= reload_pattern.size():
			reload_position = 0
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
	
	if velocity.x > top_speed:
		velocity.x = top_speed
	elif velocity.x < -top_speed:
		velocity.x = -top_speed
		
	position += velocity * delta
	position = position.clamp(screen_offset, screen_size)
	if position.x == screen_size.x or position.x == screen_offset.x:
		velocity.x = -velocity.x

		
