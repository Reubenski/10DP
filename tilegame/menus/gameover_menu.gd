extends Control

func _ready():
	var fire_sound = load("res://art/explosion.mp3")
	$AudioStreamPlayer.stream = fire_sound
	$AudioStreamPlayer.play()
	$Label.text = 'Game Over\nScore: %s' % Global.score

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Main.tscn")
