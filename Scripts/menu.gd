extends Control

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/level_select.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

func _on_play_mouse_entered() -> void:
	pass # Do something on mouse hover?

func _on_slider_value_changed(value: float) -> void:
	var lab : Label = get_node("MarginContainer/VBoxContainer/Volume/Value") 
	lab.text = str(value)


func _on_github_pressed() -> void:
	OS.shell_open("https://github.com/carllb/IsoCars/")

func _on_artist_pressed() -> void:
	#TODO: fill in artist URL
	OS.shell_open("https://twitter.com/corvidscorpse") 

func _on_test_pressed() -> void:
	#TODO: what is the point of this button?
	OS.shell_open("https://test.com") 
