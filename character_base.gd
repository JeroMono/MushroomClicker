extends CharacterBody2D

#@onready var scoreLabel = $"Score"
@onready var timerLabel = $"../Timer"
@onready var posLabel = $"../Pos"
@onready var score = 0
@onready var randomAngulo = randf()*2*PI
@onready var speed = 10.0
@onready var direction = Vector2(sin(randomAngulo),cos(randomAngulo))
@onready var margen = 50
@onready var velocidad_base = 10.0
@onready var puntuacion_click = 10
@onready var tamaño_pantalla = Vector2(0,0)
@onready var angulo_min = 0.9
@onready var animatedSprite = $AnimatedSprite2D
@onready var clicks_recibidos = 0
@onready var tamaño_x = $AnimatedSprite2D.scale.x
@onready var sonido_pulsar = "res://sounds/noise channel SFX/RPGSFX - 64 hit 1.ogg"

func _ready():
	animatedSprite.play("run")
	# scoreLabel.text = "Score: %d" % score
	print(randomAngulo)
	animatedSprite.connect("animation_finished", Callable(self, "_on_animation_finished"))
	position = Vector2(randf()*get_viewport_rect().size.x, randf()*get_viewport_rect().size.y)
	$AudioStreamPlayer.stream = load(sonido_pulsar)
	
func _process(delta: float) -> void:
	animatedSprite.speed_scale = 1 + (clicks_recibidos*abs(puntuacion_click))/(speed*50)
	var direction_normalizada = direction.normalized()
	tamaño_pantalla = get_viewport_rect().size
	position += direction*(velocidad_base*(1+(clicks_recibidos*abs(puntuacion_click))/speed))*delta
	if position.y > tamaño_pantalla.y - margen:
		direction = Vector2(direction_normalizada.x,-direction_normalizada.y)
		
		randomAngulo = randf()*PI/2*angulo_min+PI
		direction = Vector2(sin(randomAngulo),cos(randomAngulo))
		print(position)
		animatedSprite.play("hit")
	elif position.y < margen:
		direction = Vector2(direction_normalizada.x, -direction_normalizada.y)
		randomAngulo = randf()*PI/2*angulo_min+PI*2
		direction = Vector2(sin(randomAngulo),cos(randomAngulo))
		print(position)
		animatedSprite.play("hit")
	if position.x > tamaño_pantalla.x - margen:
		direction = Vector2(-direction_normalizada.x, direction_normalizada.y)
		randomAngulo = randf()*PI/2*angulo_min+PI*3/2
		direction = Vector2(sin(randomAngulo),cos(randomAngulo))
		animatedSprite.play("hit")
		print(position)
	elif position.x < margen:
		direction = Vector2(-direction_normalizada.x, direction_normalizada.y)
		randomAngulo = randf()*PI/2*angulo_min+PI/2
		direction = Vector2(sin(randomAngulo),cos(randomAngulo))
		animatedSprite.play("hit")
		print(position)
	if direction.x > 0:
		$AnimatedSprite2D.scale.x = -tamaño_x
	else:
		$AnimatedSprite2D.scale.x = tamaño_x

func actualizarPuntuacion():
	#scoreLabel.text = "Score: %d" % Puntuacion.puntuacion
	pass
	
func sumarPuntuacion(puntaje):
	Puntuacion.puntuacion += puntaje
	
func agregarPuntuación(puntaje):
	sumarPuntuacion(puntaje)
	actualizarPuntuacion()
	$AudioStreamPlayer.play()
#func _input_event(viewport, event, shape_idx):
	#if event is InputEventMouseButton:
		#if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#agregarPuntuación(10)


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("LeftClick"):
		agregarPuntuación(puntuacion_click)

func _on_animation_finished():
	if animatedSprite.animation != "run":
		animatedSprite.play("run")
