extends Label

func callback():
	get_tree().paused = false
	
	if get_node("/root/Minigame1/Pause3D/PauseLayer/Pause") != null:
		get_node("/root/Minigame1/Pause3D/PauseLayer/Pause").visible = false
		
	else:
		get_node("/root/Minigame1Multy/Pause3D/PauseLayer/Pause").visible = false
	