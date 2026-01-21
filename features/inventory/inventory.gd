extends PanelContainer


func _ready() -> void:
	ElementsManager.add_element.connect(_update_inventory)
	ElementsManager.substract_element.connect(_update_inventory)
	var elements = GameData.get_elements()
	for e in elements:
		var element = ElementLibrary.ELEMENTS.get(e)
		var label = Label.new()
		$"ScrollContainer/Elements Container".add_child(label)
		label.text = element.get('symbol') + ': ' + str(elements[e])
		label.name = element.get('name')


func _update_inventory(element: ElementIds.Type, quantity: int) -> void:
	var element_data = ElementLibrary.ELEMENTS.get(element)
	var text = element_data.get('symbol') + ': ' + str(GameData.get_element_quantity(element))
	if $"ScrollContainer/Elements Container".has_node(element_data.name):
		$"ScrollContainer/Elements Container".get_node(element_data.name).text = text
	else:
		var label = Label.new()
		$"ScrollContainer/Elements Container".add_child(label)
		label.text = text
		label.name = element_data.name
	pass
