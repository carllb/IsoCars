extends Node2D

class_name GameOverScreen


func initilize(money_spent: int, cars_killed: int):
	$MoneyLabel.text = "Money Spent: " + str(money_spent)
	$CarsLabel.text = "Cars Killed: " + str(cars_killed)

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")
