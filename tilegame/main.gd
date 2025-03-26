extends Node

@export var saucer : PackedScene
@export var spawn_time = 2
var spawn_counter = 0

func _process(delta):
	if spawn_counter <= 0:
		var p = saucer.instantiate()
		add_child(p)
		p.transform = $SpawnPoint.transform
		spawn_counter = spawn_time
	spawn_counter -= delta
