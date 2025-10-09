extends CharacterBody2D

@onready var scoreLabel = $"../Score"
@onready var timerLabel = $"../Timer"
@onready var posLabel = $"../Pos"
@onready var time = 20
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

func _ready():
	animatedSprite.play("run")
	scoreLabel.text = "Score: %d" % score
	timerLabel.text = "Timer: %d" % time
	print(randomAngulo)
	animatedSprite.connect("animation_finished", Callable(self, "_on_animation_finished"))

func _process(delta: float) -> void:
	animatedSprite.speed_scale = 1 + Puntuacion.puntuacion/(speed*50)
	#if Input.is_action_just_pressed("wclick"):
		#agregarPuntuación(5)
	#if Input.is_action_just_pressed("qclick"):
		#agregarPuntuación(500)
	var direction_normalizada = direction.normalized()
	tamaño_pantalla = get_viewport_rect().size
	#var angulo = direction.angle() #+ (randf()*2*PI-PI)
	#var direction_normalizada = Vector2(sin(angulo),cos(angulo))
	position += direction*(velocidad_base*(1+Puntuacion.puntuacion/speed))*delta
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
	if time > 0:
		time -= delta
	if time < 0:
		time = 0
		get_tree().change_scene_to_file("res://GameOver.tscn")
	if direction.x > 0:
		$AnimatedSprite2D.scale.x = -2.0
	else:
		$AnimatedSprite2D.scale.x = 2.0
	timerLabel.text = "Timer: %d" % time

func actualizarPuntuacion():
	scoreLabel.text = "Score: %d" % Puntuacion.puntuacion
	
func sumarPuntuacion(puntaje):
	Puntuacion.puntuacion += puntaje
	
func agregarPuntuación(puntaje):
	sumarPuntuacion(puntaje)
	actualizarPuntuacion()
	#
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
