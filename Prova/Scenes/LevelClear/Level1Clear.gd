extends Area2D

var fade_class = load("res://Scenes/Fade/Fade.tscn")

func _process(delta):
	var bodies = self.get_overlapping_bodies()
	for body in bodies:
		if "Player" in body.name:
			callback()
			set_process(false)
			
			

func callback():
	get_tree().paused = true
	$LevelClearSound.play()
	add_child(fade_class.instance())
	yield(get_tree().create_timer(0.7),"timeout")
	SceneManager.goto_scene("res://Scenes/LevelClear/Level2Screen.tscn")