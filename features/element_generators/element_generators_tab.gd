extends ScrollContainer

@export var generator_container: PackedScene

func _ready() -> void:
	var generators = GameData.get_generators()
	for g in generators:
		var generator = generator_container.instantiate()
		$GridContainer.add_child(generator)
		generator.set_up(int(g), generators[g])
		generator.name = 'Generator: ' + str(g)
	GeneratorManager.generator_unlocked.connect(_on_generator_unlocked)

func _on_resized() -> void:
	var total_width = size.x
	var item_width = 380
	var spacing = 8
	
	# We factor in the spacing between columns
	# Formula: (TotalWidth + Spacing) / (ItemWidth + Spacing)
	var new_columns = floor((total_width + spacing) / (item_width + spacing))
	
	# Ensure we have at least 1 column
	$GridContainer.columns = max(1, int(new_columns))

func _on_generator_unlocked(element: ElementIds.Type) -> void:
	if not $GridContainer.has_node('Generator: ' + str(element)):
		var generator = generator_container.instantiate()
		$GridContainer.add_child(generator)
		generator.name = 'Generator: ' + str(element)
		generator.set_up(element, 1)
