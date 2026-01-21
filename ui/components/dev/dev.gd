extends Control


var open_menu: bool = false


func _on_dev_button_dev_button_clicked() -> void:
	open_menu = !open_menu
	$"Dev Menu".visible = open_menu


func _on_energy_input_text_submitted(new_text: String) -> void:
	var energy = int(new_text)
	GameData._set_energy(energy)
	EnergyManager.add_energy.emit(0)


func _on_reset_button_pressed() -> void:
	GameData.data = GameSettings.DEFAULT_SAVE.duplicate(true)
	GameData._save_data()
	get_tree().quit()
