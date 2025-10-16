extends "res://character_base.gd"


func _ready():
	sonido_pulsar = "res://sounds/square channel SFX/low beep.ogg"
	super._ready()
	velocidad_base = 350
	speed = 50
	puntuacion_click = -50
	$AnimatedSprite2D.modulate = Color(0.923, 0.0, 0.144, 1.0)
