extends Node2D

var fade_class = load("res://Scenes/Fade/Fade.tscn")

func _ready():
	get_tree().paused = true
	Global.resetLives()
	var fade_instance = fade_class.instance()
	fade_instance.set_fade_in(true)
	add_child(fade_instance)
	#yield(get_tree().create_timer(0.2),"timeout")
	get_tree().paused = false
	
