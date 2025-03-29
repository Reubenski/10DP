extends Node2D

var bricks =  10
var people =10
var metal =10

func _ready():
	$CityMap
	pass

	
	
func _input(event):
	if event is InputEventMouseButton:
		var pos = event.position
		var position = $CityMap.local_to_map($CityMap.to_local(pos));
		if event.pressed:
			print(position)
			$CityMap.set_cell(position,0,Vector2i(0,0))
