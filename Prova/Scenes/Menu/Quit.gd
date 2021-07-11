extends Label

func callback():
	$"/root/GameSaver".save(0)
	get_tree().quit()
