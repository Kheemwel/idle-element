extends Node


signal add_energy(amount: float)
signal subtract_energy(amount: float)


func _ready() -> void:
	add_energy.connect(_on_add_energy)
	subtract_energy.connect(_on_subtract_energy)


func _on_add_energy(amount: float) -> void:
	GameData._set_energy(GameData.get_energy() + amount)


func _on_subtract_energy(amount: float) -> void:
	GameData._set_energy(GameData.get_energy() - amount)
