extends PanelContainer

signal element_selected(element: ElementIds.Type)

enum Mode { FUSION, FISSION}
@export var mode: Mode = Mode.FUSION
@export var element_button: PackedScene


func _ready() -> void:
	var elements = ElementLibrary.ELEMENTS
	match (mode):
		Mode.FUSION:
			for e in elements:
				if not elements[e].has('fusion'):
					continue
				var button = element_button.instantiate()
				$GridContainer.add_child(button)
				button.set_up(e)
				button.element_button_pressed.connect(_on_element_selected)
		Mode.FISSION:
			for e in elements:
				if not elements[e].has('fission'):
					continue
				var button = element_button.instantiate()
				$GridContainer.add_child(button)
				button.set_up(e)
				button.element_button_pressed.connect(_on_element_selected)


func _on_element_selected(element: ElementIds.Type) -> void:
	element_selected.emit(element)
