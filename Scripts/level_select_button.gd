extends Node
signal level_selected

var level_choice :TDLevel =load("res://Scripts/main.gd").new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func listen(level_selected_cb, button_level:TDLevel):
	level_selected.connect(level_selected_cb) # Replace with function body.

func _on_pressed():
	level_selected.emit()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
