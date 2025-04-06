extends Node2D


@export var tiles_per_side = 10.0

@onready var sidebar = get_node('/root/Main/SidebarUi')


var mouse_position
var tileindex = Vector2i(0,0)

var tile

func _ready():
	var scalenum =(800.0/$CityMap.tile_set.tile_size.x)/tiles_per_side
	$CityMap.scale = Vector2(scalenum,scalenum)

	pass

func get_select_coords(itemlist): 
	if tile != null:
		print(itemlist.get_selected_items().get(0)*4)
		#converts the singular selected item into atlas coords
	
	return Vector2i(itemlist.get_selected_items().get(0)*4,0)

	
func passive_gathering():
	var totalset:Dictionary  

	for atlasid in range(3):
		totalset[sidebar.resources.keys()[atlasid]] = $CityMap.get_used_cells_by_id(0,Vector2i(atlasid*4,0)).size()

	sidebar.earned(totalset)
	
func custom_data(thing: String):
		var customData = $CityMap.tile_set.get_source(0).get_tile_data(tileindex,0)
		if customData:
			print(customData.get_custom_data(thing))  ##ensure the data pipeline matches type
			return sidebar._buildingplaced(customData.get_custom_data(thing))
		else: 
			print('data not found')
			return null
		
#for every 'passive' tile on screen (map), add respective num to resources(sidebar)

func _input(event):
	if event is InputEventMouseButton:
		mouse_position = $CityMap.local_to_map($CityMap.get_local_mouse_position())
		
		

		var itemlist = sidebar.get_child(0)

		if mouse_position[0] < 0 and mouse_position[0] >= -tiles_per_side :
			
			if event.pressed:
				if !itemlist.get_selected_items().is_empty():
					tileindex= get_select_coords(itemlist)
					if custom_data('cost'):
						$CityMap.set_cell(mouse_position,0,tileindex)
					else: print('you are too poor')
				else:
					print('nothing selected')

#invert tiles horizontally and vertically and then rotate the tilemap 180 degrees
