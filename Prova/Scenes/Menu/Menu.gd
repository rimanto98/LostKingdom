extends Control

func _ready():
	if $"/root/Global".firstStart:
		$"/root/GameSaver".load(0)
		$"/root/Global".firstStart = false
		
	