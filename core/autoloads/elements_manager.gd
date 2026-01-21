extends Node


signal add_element(element: ElementIds.Type, quantity: int)
signal substract_element(element: ElementIds.Type, quantity: int)


func _ready() -> void:
	add_element.connect(_on_add_element)
	substract_element.connect(_on_subtract_element)

func _on_add_element(element: ElementIds.Type, quantity: int) -> void:
	if GameData.get_elements().has(element):
		var new_quantity = GameData.get_element_quantity(element) + quantity
		GameData._set_element(element, new_quantity)
	else:
		GameData._set_element(element, quantity)

func _on_subtract_element(element: ElementIds.Type, quantity: int) -> void:
	GameData._set_element(element, GameData.get_element_quantity(element) - quantity)
