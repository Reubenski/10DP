extends Node2D

var bricks =  10
var people =10
var metal =10

func _ready():
	pass

	
	
func _input(event):
	if event is InputEventMouseButton:
		var pos = event.position
		var position = $CityMap.local_to_map($CityMap.to_local(pos));
		
		if event.pressed:
			var itemlist = get_node("/root/Main/SidebarUi").get_child(0)
			if !itemlist.get_selected_items().is_empty():
				$CityMap.set_cell(position,0,Vector2i(itemlist.get_selected_items().get(0)*4,0))
			
