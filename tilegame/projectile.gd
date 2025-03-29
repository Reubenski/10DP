extends Area2D

var speed = 400
@export var explosion : PackedScene

func explode():
	var p = explosion.instantiate()
	get_parent().add_child(p)
	p.transform = $ExplosionPoint.global_transform
	
func _process(delta):
	position.y -= speed * delta
	if position.y < -500:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("aliens"):
		explode()
		area.queue_free()
		queue_free()
