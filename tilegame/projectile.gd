extends Area2D

var speed = 400

func _process(delta):
	position.y -= speed * delta
	if position.y < 0:
		queue_free()



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("aliens"):
		area.queue_free()
		queue_free()
