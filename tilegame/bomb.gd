extends Area2D



var speed = 400
var screen_size



func _ready():
	screen_size = get_viewport_rect().size


func gettingmap(pos):

	var tiles = get_node("/root/Main/map").get_child(1) 
	
	tiles.erase_cell(tiles.local_to_map(tiles.to_local(pos)))



func _process(delta):
	position.y += speed * delta
	if position.y > screen_size.y:
		queue_free()
	gettingmap(global_position)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		area.queue_free()
		queue_free()
