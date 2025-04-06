extends Node2D
var lifetime = 4;

func _ready():
	var fire_sound = load("res://art/explosion.mp3")
	$AudioStreamPlayer.stream = fire_sound
	$AudioStreamPlayer.play()

func _process(delta):
	lifetime -= delta
	if (lifetime < 0):
		queue_free()

	
