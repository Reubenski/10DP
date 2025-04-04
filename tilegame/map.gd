extends Node2D


@export var tiles_per_side = 10.0


var bricks =  10
var people =10
var metal =10

var mouse_position
var tileindex

var tile

func _ready():
	var scalenum =(800.0/$CityMap.tile_set.tile_size.x)/tiles_per_side
	$CityMap.scale = Vector2(scalenum,scalenum)

	pass

func get_select_coords(itemlist): 
	if tile != null:
		print(itemlist.get_selected_items().get(0)*4)
	
	return Vector2i(itemlist.get_selected_items().get(0)*4,0)

	
	
	
func _resource_change(resource: String ,amount:int):

	tile= $CityMap.get_cell_tile_data(mouse_position)
	if tile:
		print(tile.get_custom_data(resource))
	else:
		
		print(tileindex)
		print('no tile at this index')

func _input(event):
	if event is InputEventMouseButton:
		mouse_position = $CityMap.local_to_map($CityMap.get_local_mouse_position())
		
		

		var itemlist = get_node("/root/Main/SidebarUi").get_child(0)

		if mouse_position[0] < 0 and mouse_position[0] >= -tiles_per_side :
			
			if event.pressed:
				if !itemlist.get_selected_items().is_empty():
					tileindex= get_select_coords(itemlist)
					$CityMap.set_cell(mouse_position,0,tileindex)
					#resource_change('people',1)
				else:
					print('nothing selected')

#invert tiles horizontally and vertically and then rotate the tilemap 180 degrees
