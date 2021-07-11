extends Label

var fade_class = load("res://Scenes/Fade/Fade.tscn")

func callback():
	add_child(fade_class.instance())
	yield(get_tree().create_timer(0.7),"timeout")
	get_tree().paused = false
	SceneManager.goto_scene("res://Scenes/Minigame1/MenuMinigame3D/Menu.tscn")
