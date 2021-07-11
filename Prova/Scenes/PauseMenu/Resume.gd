extends Label

func callback():
	get_tree().paused = false
	get_node("/root/Game/Player/Camera2D/PauseLayer/Pause").visible = false
	