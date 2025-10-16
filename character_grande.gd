extends "res://character_player.gd"

func _ready():
	sonido_pulsar = "res://sounds/noise channel SFX/RPGSFX - 66 fast fall 1.ogg"
	super._ready()
	velocidad_base = 5
	puntuacion_click = 10
