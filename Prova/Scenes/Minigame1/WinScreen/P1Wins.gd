extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect/Spatial/Viewport/Ball.hide()
	yield(get_tree().create_timer(0.1),"timeout")
	$ColorRect/Spatial/Viewport/Ball.show()
	yield(get_tree().create_timer(5),"timeout")
	SceneManager.goto_scene("res://Scenes/Minigame1/MenuMinigame3D/Menu.tscn")