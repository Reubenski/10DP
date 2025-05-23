extends Control

func _ready():
	var tween = create_tween()
	tween.tween_property($ColorRect/introtext, "self_modulate", Color.TRANSPARENT, 3)
	tween.tween_property($ColorRect, "self_modulate", Color.TRANSPARENT, 1)
func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Main.tscn")
