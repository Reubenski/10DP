extends Node

@export var saucer : PackedScene
@export var mothership : PackedScene
var waveNo = 0
var wave = [];
var waveTimer = 0

func _ready():
	Global.score = 0

func _process(delta):
	if get_tree().get_nodes_in_group("aliens").size() == 0 and wave.size() == 0:
		#modulate resourcelistui to green
		$map.passive_gathering()
		waveNo = waveNo + 1;
		wave = []
		for i in range(0,waveNo):
			wave.append(0.3)
		#wait then modulate resourcelistui to white
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
