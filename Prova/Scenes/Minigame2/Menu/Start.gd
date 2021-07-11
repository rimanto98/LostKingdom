extends Label

var fade_class = load("res://Scenes/Fade/Fade.tscn")

func callback():
	get_parent().add_child(fade_class.instance())
	yield(get_tree().create_timer(0.7),"timeout")
	SceneManager.goto_scene("res://Scenes/Minigame2/SpaceInvadersAI.tscn")