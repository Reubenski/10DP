extends Area2D

var speed = 400
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	position.y += speed * delta
	if position.y > screen_size.y:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("player"):
		area.queue_free()
		queue_free()
