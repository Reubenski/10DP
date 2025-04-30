extends Node
signal next_wave

@export var saucer : PackedScene
@export var mothership : PackedScene
var waveNo = 0
var wave = [];
var waveTimer = 0
var pause = false
var mobile_list=["Android", "BlackBerry 10","iOS"]
func _ready():
	
	if OS.get_name() in mobile_list:
		$TouchScreencontrols.visible =true

	Global.score = 0
	Global.paused = false

func _process(delta):
	if Global.paused:
		return
	if get_tree().get_nodes_in_group("aliens").size() == 0 and wave.size() == 0:
		#modulate resourcelistui to green
		if waveNo>0:
			$map.passive_gathering()
		waveNo = waveNo + 1;
		next_wave.emit(waveNo)
		$SpawnPoint.position.x = randi_range(250,950)
		#find a 
		#await get_tree().create_timer(3).timeout  this CAUSES MANY ISSUES
		wave = []
		for i in range(0,waveNo):
			wave.append(0.3)
		#wait then modulate resourcelistui to white
	if wave.size() > 0 and waveTimer > wave[0]:
		if waveNo % 3 == 0 and wave.size() % 3 ==0:
			var p = mothership.instantiate()
			add_child(p)
			p.transform = $MothershipSpawn.transform
			waveTimer = 0
			wave.remove_at(0)
		else:
			var p = saucer.instantiate()
			add_child(p)
			
			p.transform = $SpawnPoint.transform
			waveTimer = 0
			wave.remove_at(0)
	waveTimer += delta

func shake()->void:
	#CAMERA 2D NODE
	#small array of random vectors for adding to position
	# array must contain vectors bewtween -10 and +10
	#add original position to both beginneing and end of array
	$map.global_position+=Vector2i()
	pass#move screen around
