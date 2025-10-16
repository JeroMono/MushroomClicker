extends Label

@onready var time = 60

func _ready():
	text = "Timer" + str(time)

func _on_timer_timeout() -> void:
	if time > 0:
		time -= 1
		text = "Timer" + str(time)
	if time <= 0:
		time = 0
		get_tree().change_scene_to_file("res://GameOver.tscn")
