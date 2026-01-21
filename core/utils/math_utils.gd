class_name MathUtils


static func get_upgrade_cost(element: ElementIds.Type, level: int) -> float:
	var base_upgrade_cost = ElementLibrary.ELEMENTS.get(element).get('base_upgrade_cost')
	return  base_upgrade_cost * pow(GameSettings.UPGRADE_COST_MULTIPLIER, level - 1)


static func get_production_rate(element: ElementIds.Type, level: int) -> float:
	var base_production_rate = ElementLibrary.ELEMENTS.get(element).get('base_production_rate')
	var r = GameSettings.MAX_TIME_REDUCTION / (GameSettings.MAX_GENERATORS_LEVEL - 1)
	return base_production_rate * (1 - r * (level - 1))

	
