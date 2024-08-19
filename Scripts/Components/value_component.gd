extends Node
class_name ValueComponent

var value: int = 5

func _init(value_val: int):
	value = value_val

func get_value() -> int:
	return value

func can_afford(cost_value: ValueComponent) -> bool:
	return (cost_value.get_value() <= value)

func add_value(additional_value: ValueComponent):
	value += additional_value.get_value()

func change_by_percent(percent: float):
	value = value + floor(value * (percent/100.0))

func spend_value(cost: ValueComponent):
	value -= cost.get_value()
