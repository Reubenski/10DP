extends Node

@export var saucer : PackedScene
var waves = [3,3,0.3,5,0.3,0.3,4,0.3]
var current_wave = 0
var spawn_counter = 4

func _process(delta):
	if spawn_counter <= 0:
		var p = saucer.instantiate()
		add_child(p)
		p.transform = $SpawnPoint.transform
		spawn_counter = waves[current_wave]
		current_wave += 1
		if current_wave >= len(waves):
			current_wave = 0
	spawn_counter -= delta
