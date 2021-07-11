extends Control

var fade_class = load("res://Scenes/Fade/Fade.tscn")


func _ready():
	var fade_instance = fade_class.instance()
	fade_instance.set_fade_in(true)
	add_child(fade_instance)