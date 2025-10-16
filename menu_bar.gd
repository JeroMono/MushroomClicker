extends MenuBar

func _on_renaudar_button_pressed() -> void:
	toggle_pause()

func _on_salir_button_pressed() -> void:
	toggle_pause()
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _unhandled_input(event):
	if event.is_action_pressed("Escape"):
		toggle_pause()
		

func toggle_pause():
	var t := get_tree()
	t.paused = !t.paused
	visible = t.paused
	if t.paused:
		process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	else:
		process_mode = Node.PROCESS_MODE_INHERIT
