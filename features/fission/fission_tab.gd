extends Control

var fission_element: ElementIds.Type
var element_produce: Variant = null
var energy_produce: float = 0
var is_pressing: bool = false
var current_progress: float = 0

func _ready() -> void:
	_on_element_selector_element_selected(ElementIds.Type.HYDROGEN)


func _process(delta: float) -> void:
	if is_pressing:
		# Add the time passed since last frame
		current_progress += delta
		
		# Clamp the value so it doesn't go past 10
		current_progress = min(current_progress, GameSettings.FISSION_DURATION)
		
		# Update the bar visual
		var value = (current_progress / GameSettings.FISSION_DURATION) * 100
		$"Fission Progress".value = value
		
		if current_progress >= GameSettings.FISSION_DURATION:
			current_progress = 0
			_fission()
	else:
		# OPTIONAL: Slowly drain the bar if they let go 
		# (Remove these 2 lines if you want it to stay stuck where they left off)
		current_progress = lerp(current_progress, 0.0, delta * 2.0)
		var value = (current_progress / GameSettings.FISSION_DURATION) * 100
		$"Fission Progress".value = value


func _fission():
	ElementsManager.substract_element.emit(fission_element, 1)
	EnergyManager.add_energy.emit(energy_produce)
	if element_produce != null:
		ElementsManager.add_element.emit(element_produce, 2)
	pass


func _on_element_selector_element_selected(element: ElementIds.Type) -> void:
	fission_element = element
	var fission_element_data = ElementLibrary.ELEMENTS.get(element)
	element_produce = fission_element_data.get('fission').get('element_produce')
	energy_produce = fission_element_data.get('fission').get('energy_produce')
	$"Fission Element".text = fission_element_data.get('symbol')
	$"Element Selector".hide()
	$"Fission Element".button_pressed = false


func _on_fission_element_toggled(toggled_on: bool) -> void:
	$"Element Selector".visible = toggled_on


func _on_fission_button_button_up() -> void:
	is_pressing = false


func _on_fission_button_button_down() -> void:
	is_pressing = true
