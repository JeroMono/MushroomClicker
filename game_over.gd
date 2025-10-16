extends Control

@onready var puntajeLabel = $PuntuacionLabel

func _process(delta: float) -> void:
	puntajeLabel.text = "Puntuacion: " + str(Puntuacion.puntuacion)


func _on_button_play_pressed() -> void:
	Puntuacion.puntuacion = 0
	
	Puntuacion.level = 1
	get_tree().change_scene_to_file("res://game.tscn")


func _on_button_menu_pressed() -> void:
	Puntuacion.puntuacion = 0
	
	Puntuacion.level = 1
	get_tree().change_scene_to_file("res://main_menu.tscn")
