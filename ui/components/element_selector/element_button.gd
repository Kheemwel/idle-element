extends Button

signal element_button_pressed(element: ElementIds.Type)

var element_id: ElementIds.Type


func set_up(element: ElementIds.Type) -> void:
	element_id = element
	var element_data = ElementLibrary.ELEMENTS.get(element)
	text = element_data.get('symbol')


func _pressed() -> void:
	element_button_pressed.emit(element_id)
