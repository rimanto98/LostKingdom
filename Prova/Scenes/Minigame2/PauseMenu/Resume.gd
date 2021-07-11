extends Label

func callback():
	get_tree().paused = false
	get_node("/root/SpaceInvadersAI/PauseNode/PauseLayer/Pause").visible = false
	