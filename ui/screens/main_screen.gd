extends Control

enum Tab { GENERATORS, FUSION, FISSION}

var selected_tab: Tab = Tab.GENERATORS

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_update_tab()
	EnergyManager.add_energy.connect(_update_energy_label)
	EnergyManager.subtract_energy.connect(_update_energy_label)
	_update_energy_label(GameData.get_energy())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _update_tab():
	$"VBoxContainer/Main Container/Elements Tab".hide()
	$"VBoxContainer/Main Container/Fusion Tab".hide()
	$"VBoxContainer/Main Container/Fission Tab".hide()
	$"VBoxContainer/Main Container/Tab Bar/Elements Tab".button_pressed = false
	$"VBoxContainer/Main Container/Tab Bar/Fusion Tab".button_pressed = false
	$"VBoxContainer/Main Container/Tab Bar/Fission Tab".button_pressed = false
	match(selected_tab):
		Tab.GENERATORS:
			$"VBoxContainer/Main Container/Elements Tab".show()
			$"VBoxContainer/Main Container/Tab Bar/Elements Tab".button_pressed = true
		Tab.FUSION:
			$"VBoxContainer/Main Container/Fusion Tab".show()
			$"VBoxContainer/Main Container/Tab Bar/Fusion Tab".button_pressed = true
		Tab.FISSION:
			$"VBoxContainer/Main Container/Fission Tab".show()
			$"VBoxContainer/Main Container/Tab Bar/Fission Tab".button_pressed = true


func _update_energy_label(amount: float) -> void:
	$"VBoxContainer/Top Bar/PanelContainer/HBoxContainer/Energy Label".text = "%0.1f" % GameData.get_energy()


func _on_elements_tab_pressed() -> void:
	selected_tab = Tab.GENERATORS
	_update_tab()


func _on_fusion_tab_pressed() -> void:
	selected_tab = Tab.FUSION
	_update_tab()


func _on_fission_tab_pressed() -> void:
	selected_tab = Tab.FISSION
	_update_tab()


func _on_inventory_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		$Inventory.show()
	else:
		$Inventory.hide()
	pass # Replace with function body.
