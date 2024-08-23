extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_map_1_button_pressed() -> void:
	
	var level:TDLevel = preload("res://Scenes/main.tscn").instantiate()
	Global.level_choice = level
	#Global.mob_path = preload("res://Scenes/mob_path1.tscn")
	get_tree().change_scene_to_file("res://Scenes/ui.tscn")

func _on_map_2_button_pressed() -> void:		
	var level:TDLevel = preload("res://Scenes/chris1.tscn").instantiate()
	Global.level_choice = level
	#Global.mob_path = preload("res://Scenes/mob_path2.tscn")
	get_tree().change_scene_to_file("res://Scenes/ui.tscn")


func _on_map_3_button_pressed() -> void:
	var level:TDLevel = preload("res://Scenes/chris2.tscn").instantiate()
	Global.level_choice = level
	#Global.mob_path = preload("res://Scenes/mob_path3.tscn")
	get_tree().change_scene_to_file("res://Scenes/ui.tscn")


func _on_map_4_button_pressed() -> void:
	var level:TDLevel = preload("res://Scenes/chris3.tscn").instantiate()
	Global.level_choice = level
	#Global.mob_path = preload("res://Scenes/mob_path4.tscn")
	get_tree().change_scene_to_file("res://Scenes/ui.tscn")
