class_name ElementLibrary

const ELEMENTS: Dictionary[ElementIds.Type, Dictionary] = {
	ElementIds.Type.HYDROGEN: {
		"name": "Hydrogen",
		'symbol': 'H',
		"base_production_rate": 5, #seconds
		"base_upgrade_cost": 5, #10 energy
		"fission": {
			"energy_produce": 1
		},
		"color": "#00ff00"
	},
	ElementIds.Type.HELIUM: {
		"name": "Helium",
		'symbol': 'He',
		"base_production_rate": 5, 
		"base_upgrade_cost": 10, 
		"fusion": {
			"element_requirement": ElementIds.Type.HYDROGEN,
			"energy_cost": 5
		},
		"fission": {
			"element_produce": ElementIds.Type.HYDROGEN,
			"energy_produce": 1.5
		},
		"color": "#ff0000"
	},
	ElementIds.Type.LITHIUM: {
		"name": "Lithium",
		'symbol': 'Li',
		"base_production_rate": 10,
		"base_upgrade_cost": 15, 
		"fusion": {
			"element_requirement": ElementIds.Type.HELIUM,
			"energy_cost": 10
		},
		"fission": {
			"element_produce": ElementIds.Type.HELIUM,
			"energy_produce": 2
		},
		"color": "#0000ff"
	},
}
