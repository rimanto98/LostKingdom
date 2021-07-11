extends Spatial

var fade_class = load("res://Scenes/Fade/Fade.tscn")
var countdown_class = load("res://Scenes/Minigame1/Countdown/Countdown.tscn")

func _ready():
	stopProcess()
	$Pause3D/PauseLayer/Pause.set_process_input(false)
	var fade_instance = fade_class.instance()
	fade_instance.set_fade_in(true)
	add_child(fade_instance)
	var countdown_instance = countdown_class.instance()
	add_child(countdown_instance)
	yield(get_tree().create_timer(4),"timeout")
	$Pause3D/PauseLayer/Pause.set_process_input(true)
	restartProcess()
	

func _on_Enemy_death():
	stopProcess()
	add_child(fade_class.instance())
	yield(get_tree().create_timer(0.7),"timeout")
	SceneManager.goto_scene("res://Scenes/Minigame1/WinScreen/P1Wins.tscn")


func _on_Ball_death():
	stopProcess()
	add_child(fade_class.instance())
	yield(get_tree().create_timer(0.7),"timeout")
	if name == "Minigame1":
		SceneManager.goto_scene("res://Scenes/Minigame1/WinScreen/EnemyWins.tscn")
	else:
		SceneManager.goto_scene("res://Scenes/Minigame1/WinScreen/P2Wins.tscn")
	
func _on_Ball2_death():
	stopProcess()
	add_child(fade_class.instance())
	yield(get_tree().create_timer(0.7),"timeout")
	SceneManager.goto_scene("res://Scenes/Minigame1/WinScreen/P1Wins.tscn")
	
func stopProcess():
	$Ball.set_process(false)
	
	if self.name == "Minigame1":
		$Enemy.set_process(false)
	else:
		$Ball2.set_process(false)
		
		
func restartProcess():
	$Ball.set_process(true)
	
	if self.name == "Minigame1":
		$Enemy.set_process(true)
	else:
		$Ball2.set_process(true)


