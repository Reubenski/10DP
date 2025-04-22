extends Area2D

@export var explosion : PackedScene
var speed = 400
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play()

func explode():
	var p = explosion.instantiate()
	get_parent().add_child(p)
	p.transform = $ExplosionPoint.global_transform

func gettingmap(pos):
	var tiles = get_node("/root/Main/map").get_child(1) 
	var position = tiles.local_to_map(tiles.to_local(pos));
	var tiledata = tiles.get_cell_tile_data(position)
	if tiledata != null:
		explode()
		tiles.erase_cell(position)
		queue_free()

func _process(delta):
	position.y += speed * delta
	if position.y > screen_size.y:
		queue_free()
	gettingmap(global_position)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		explode()
		area.health = area.health - 1
		if area.health <= 0:
			get_tree().change_scene_to_file("res://menus/GameoverMenu.tscn")

