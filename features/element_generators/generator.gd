extends VBoxContainer

@onready var element_symbol: Label = $"Element Detail/Element Symbol"
@onready var element_name: Label = $"Element Detail/Element Name"
@onready var level_label: Label = $"Element Level/Level"
@onready var output: Label = $"Element Level/Output"
@onready var production_progress: ProgressBar = $"Production Progress"
@onready var upgrade_button: Button = $"Upgrade Button"
@onready var progress_timer: Timer = $"Production Progress/Progress Timer"

var generator_element: ElementIds.Type
var genarator_level: int = 0
var production_rate: float = 0
var upgrade_cost: float = 0


func _ready() -> void:
	EnergyManager.add_energy.connect(_update_upgrade_button)
	EnergyManager.subtract_energy.connect(_update_upgrade_button)


func set_up(element: ElementIds.Type, level: int):
	generator_element = element
	var element_data = ElementLibrary.ELEMENTS.get(element)
	element_symbol.text = element_data.get('symbol', '')
	element_name.text = element_data.get('name', '')
	genarator_level = level
	level_label.text = 'Level ' + str(level)
	production_rate = MathUtils.get_production_rate(element, level)
	output.text = 'Output: 1 / ' + str(production_rate) + 's'
	progress_timer.wait_time = production_rate
	upgrade_cost = MathUtils.get_upgrade_cost(element, level)
	upgrade_button.text = 'Upgrade Speed\n' + str(upgrade_cost) + ' ⚡'
	if genarator_level == GameSettings.MAX_GENERATORS_LEVEL:
		upgrade_button.disabled = true


func _process(delta: float) -> void:
	var ratio = 1.0 - (progress_timer.time_left / progress_timer.wait_time)
	production_progress.value = ratio * 100


func _on_upgrade_button_pressed() -> void:
	if GameData.get_energy() >= upgrade_cost:
		genarator_level += 1
		GeneratorManager.upgrade_generator.emit(generator_element)
		progress_timer.stop()
		progress_timer.start()
		set_up(generator_element, genarator_level)
	
	_update_upgrade_button(0)


func _on_progress_timer_timeout() -> void:
	ElementsManager.add_element.emit(generator_element, 1)


func _update_upgrade_button(amount: float) -> void:
	if genarator_level == GameSettings.MAX_GENERATORS_LEVEL:
		upgrade_button.disabled = true
		upgrade_button.text = 'MAX LEVEL'
		return
	
	if GameData.get_energy() < upgrade_cost:
		upgrade_button.disabled = true
	else:
		upgrade_button.disabled = false
