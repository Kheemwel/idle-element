extends Button

signal dev_button_clicked()

@export var drag_threshold: float = 5.0 # Pixels moved before it counts as a drag
var is_dragging = false
var click_offset = Vector2.ZERO
var start_mouse_pos = Vector2.ZERO

func _gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				# 1. Store initial positions
				is_dragging = false
				start_mouse_pos = event.global_position
				click_offset = get_global_mouse_position() - global_position
			else:
				# 2. On Release: Only click if we didn't drag far
				var dist_moved = event.global_position.distance_to(start_mouse_pos)
				if dist_moved < drag_threshold:
					_on_actual_click()
				
				is_dragging = false

	if event is InputEventMouseMotion:
		# 3. If mouse moves past threshold, start dragging
		if event.button_mask == MOUSE_BUTTON_MASK_LEFT:
			var dist_moved = event.global_position.distance_to(start_mouse_pos)
			if dist_moved > drag_threshold:
				is_dragging = true
				global_position = get_global_mouse_position() - click_offset

func _on_actual_click():
	dev_button_clicked.emit()
