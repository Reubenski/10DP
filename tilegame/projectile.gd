extends Area2D

signal hit_enemy

@export var speed = 400
@export var xspeed = 0
@export var explosion : PackedScene
@export var penetrating = false
@export var homing = false

func _ready():
	hit_enemy.connect(get_node('/root/Main/SidebarUi')._ship_destroyed.bind())


func explode():
	var p = explosion.instantiate()
	get_parent().add_child(p)
	p.transform = $ExplosionPoint.global_transform
	
func _process(delta):
	position.y -= speed * delta
	if homing:
		var aliens = get_tree().get_nodes_in_group("aliens")
		if len(aliens) > 0:
			if aliens[0].position.x>position.x:
				position.x += 200*delta
			else:
				position.x -= 200*delta
	else:
		position.x += xspeed * delta
	if position.y < -500:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("aliens"):
		explode()
		area.queue_free()
		hit_enemy.emit()
		if !penetrating:
			queue_free()
