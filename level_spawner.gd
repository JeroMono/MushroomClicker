extends Node
@onready var canvasLayer= $".."
const PLAYER_GRANDE: PackedScene = preload("res://player_grande.tscn")
const PLAYER_NORMAL: PackedScene = preload("res://player_normal.tscn")
const PLAYER_PEQUE: PackedScene = preload("res://player_peque.tscn")

func spawn_player(pos: Vector2, tamaño:int) -> void:
	var player
	match tamaño:
		1:
			player = PLAYER_PEQUE.instantiate() as CharacterBody2D
		2:
			player = PLAYER_NORMAL.instantiate() as CharacterBody2D
		3:
			player = PLAYER_GRANDE.instantiate() as CharacterBody2D
		_:
			player = PLAYER_NORMAL.instantiate() as CharacterBody2D
	player.global_position = pos
	add_child(player)
	
const ENEMIGO_SCENE: PackedScene = preload("res://enemigo.tscn")


func spawn_enemy(pos: Vector2) -> void:
	var enemigo = ENEMIGO_SCENE.instantiate() as CharacterBody2D
	enemigo.global_position = pos
	add_child(enemigo)
	
func _ready() -> void:
	$"../LevelLabel".text = "Nivel: " + str(Puntuacion.level)
	match Puntuacion.level:
		1:
			spawn_player(Vector2(200, 300),2)
		2:
			spawn_player(Vector2(200, 300),1)
			spawn_player(Vector2(200, 300),3)
		3:
			spawn_player(Vector2(200, 300),1)
			spawn_enemy(Vector2(200, 3000))
