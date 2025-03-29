extends Node2D

func _ready():
	pass
	
func _input(event):
	if event is InputEventMouseButton:
		var pos = event.position
		var position = $CityMap.local_to_map($CityMap.to_local(pos));
		if event.pressed:
			print(position)
			$CityMap.set_cell(position,0,Vector2i(0,0))
