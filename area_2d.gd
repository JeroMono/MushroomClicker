extends Area2D
@onready var character = $".."
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			character.agregarPuntuación(10)
