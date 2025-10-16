extends Label

func _process(delta: float) -> void:
	text = "Score: %d" % Puntuacion.puntuacion
	match Puntuacion.level:
		1:
			if Puntuacion.puntuacion >= 500:
				Puntuacion.level = 2
				Puntuacion.puntuacion = 0
				get_tree().change_scene_to_file("res://game.tscn")
		2:
			if Puntuacion.puntuacion >= 750:
				Puntuacion.level = 3
				Puntuacion.puntuacion = 0
				get_tree().change_scene_to_file("res://game.tscn")
		3:
			if Puntuacion.puntuacion >= 500:
				Puntuacion.level = 1
				get_tree().change_scene_to_file("res://GameCompleted.tscn")
	
