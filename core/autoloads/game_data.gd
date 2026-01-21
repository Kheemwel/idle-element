extends Node

var data: Dictionary = GameSettings.DEFAULT_SAVE.duplicate(true)

func _ready() -> void:
	_load_data()


func _save_data():
	var file = FileAccess.open(GameSettings.SAVE_PATH, FileAccess.WRITE)
	var json_string = JSON.stringify(data)
	file.store_line(json_string)
	print("Game Data Saved!")


func _load_data():
	# 1. Check if the file even exists
	if not FileAccess.file_exists(GameSettings.SAVE_PATH):
		print("No save file found!")
		return
	var file = FileAccess.open(GameSettings.SAVE_PATH, FileAccess.READ)
	var json_string = file.get_as_text()
	# 2. Create a JSON object to handle the parsing
	var json = JSON.new()
	var result = json.parse(json_string)
	
	if result == OK:
		data = _fix_json_keys(json.data) # This is now your Dictionary!
	else:
		print("JSON Parse Error: ", json.get_error_message())


func _fix_json_keys(dictionary: Dictionary) -> Dictionary:
	var fixed_dict = {}
	for key in dictionary:
		var value = dictionary[key]
		
		# If the value is another dictionary (like 'generators'), fix it too!
		if value is Dictionary:
			value = _fix_json_keys(value)
		
		# If the key is a string that looks like a number, make it an int
		if key.is_valid_int():
			fixed_dict[key.to_int()] = value
		else:
			fixed_dict[key] = value
			
	return fixed_dict


func get_version() -> int:
	return data.get('version', 1)

func get_energy() -> float:
	return data.get('energy', 0)

func get_generators() -> Dictionary:
	return data.get('generators', {})

func get_elements() -> Dictionary:
	return data.get('elements', {})

func get_generator_level(element: ElementIds.Type) -> int:
	return data.get('generators').get(element)

func get_element_quantity(element: ElementIds.Type) -> int:
	return data.get('elements').get(element)

func _set_energy(amount: float) -> void:
	data.set('energy', amount)

func _set_generator(element: ElementIds.Type, level: int) -> void:
	data.get('generators').set(element, level)

func _set_element(element: ElementIds.Type, quantity: int) -> void:
	data.get('elements').set(element, quantity)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST or what == NOTIFICATION_WM_GO_BACK_REQUEST:
		_save_data()
