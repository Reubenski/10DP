extends Node

@export var saucer : PackedScene
@export var mothership : PackedScene
var waveNo = 0
var wave = [];
var waveTimer = 0
func _process(delta):
	if get_tree().get_nodes_in_group("aliens").size() == 0 and wave.size() == 0:
		$map.passive_gathering()
		waveNo = waveNo + 1;
		wave = []
		for i in range(0,waveNo):
			wave.append(0.3)
	if wave.size() > 0 and waveTimer > wave[0]:
		if waveNo % 3 == 0:
			var p = mothership.instantiate()
			add_child(p)
			p.transform = $MothershipSpawn.transform
			waveTimer = 0
			wave = []
		else:
			var p = saucer.instantiate()
			add_child(p)
			p.transform = $SpawnPoint.transform
			waveTimer = 0
			wave.remove_at(0)
	waveTimer += delta
