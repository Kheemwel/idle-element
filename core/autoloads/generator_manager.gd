extends Node


signal upgrade_generator(element: ElementIds.Type)
signal generator_unlocked(element: ElementIds.Type)


func _ready() -> void:
	upgrade_generator.connect(_on_upgrade_generator)
	ElementsManager.add_element.connect(_on_element_added)


func _on_upgrade_generator(element: ElementIds.Type) -> void:
	var level = GameData.get_generator_level(element)
	var upgrade_cost = MathUtils.get_upgrade_cost(element, level)
	EnergyManager.subtract_energy.emit(upgrade_cost)
	GameData._set_generator(element, level + 1)


func _on_element_added(element: ElementIds.Type, quantity: int) -> void:
	if GameData.get_generators().has(element):
		return
	if not GameData.get_elements().has(element):
		return
	if GameData.get_element_quantity(element) < GameSettings.AMOUNT_TO_UNLOCK_GENERATOR:
		return
	GameData._set_generator(element, 1)
	generator_unlocked.emit(element)
	print(GameData.get_generators())
