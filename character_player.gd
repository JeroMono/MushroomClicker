extends "res://character_base.gd"

func _ready():
	super._ready()

func agregarPuntuación(puntaje):
	super.agregarPuntuación(puntaje)
	clicks_recibidos += 1
