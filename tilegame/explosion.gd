extends Node2D
var lifetime = 4;

func _process(delta):
	lifetime -= delta
	if (lifetime < 0):
		queue_free()

	
