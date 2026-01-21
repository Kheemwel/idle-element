extends Control

var fusion_element: ElementIds.Type
var required_element: ElementIds.Type
var is_fusing: bool = false
var current_energy_fused: float = 0
var energy_required: float = 0


func _ready() -> void:
	_on_element_selector_element_selected(ElementIds.Type.HELIUM)


func _process(delta: float) -> void:
	if not is_fusing:
		return
	
	# 1. Calculate how much we WANT to add this frame
	var energy_per_second = energy_required / GameSettings.FUSION_DURATION
	var energy_to_add = energy_per_second * delta
	 # 2. Adjust if we are almost finished (so we don't over-subtract)
	var remaining_needed = energy_required - current_energy_fused
	if energy_to_add > remaining_needed:
		energy_to_add = remaining_needed
		
	# 3. Check if player can afford it
	if GameData.get_energy() < energy_to_add:
		is_fusing = false
		return
	# 4. Success! Subtract and Update
	EnergyManager.subtract_energy.emit(energy_to_add)
	current_energy_fused += energy_to_add
	# Update UI (Tip: Use a variable if you have multiple bars)
	var value = (current_energy_fused / energy_required) * 100
	$"HBoxContainer/CenterContainer/Fusion Progress1".value = value
	$"HBoxContainer/CenterContainer2/Fusion Progress2".value = value
	# 5. Check for completion
	if current_energy_fused >= energy_required:
		is_fusing = false
		ElementsManager.add_element.emit(fusion_element, 1)
		ElementsManager.substract_element.emit(required_element, 2)
		current_energy_fused = 0
		$"HBoxContainer/CenterContainer/Fusion Progress1".value = 0
		$"HBoxContainer/CenterContainer2/Fusion Progress2".value = 0


func _on_fuse_button_button_up() -> void:
	is_fusing = false


func _on_fuse_button_button_down() -> void:
	is_fusing = true


func _on_fusion_element_toggled(toggled_on: bool) -> void:
	$"Element Selector".visible = toggled_on


func _on_element_selector_element_selected(element: ElementIds.Type) -> void:
	fusion_element = element
	var fusion_element_data = ElementLibrary.ELEMENTS.get(element)
	required_element = fusion_element_data.get('fusion').get('element_requirement')
	energy_required = fusion_element_data.get('fusion').get('energy_cost')
	var required_element_data = ElementLibrary.ELEMENTS.get(required_element)
	$"HBoxContainer/Fusion Element".text = fusion_element_data.get('symbol')
	$"HBoxContainer/Required Element1".text = required_element_data.get('symbol')
	$"HBoxContainer/Required Element2".text = required_element_data.get('symbol')
	$"Element Selector".hide()
	$"HBoxContainer/Fusion Element".button_pressed = false
