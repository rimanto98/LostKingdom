extends Label

var camera = 1
var called = false
	
func callback():
	called = true
	
func _process(delta):
	if called:
		if camera:
			get_node("/root/Minigame1/InterpolatedCamera").set_target(get_node("/root/Minigame1/Ball/CameraTarget"))
			camera = 0
		else:
			get_node("/root/Minigame1/InterpolatedCamera").set_target(get_node("/root/Minigame1/CameraTarget2"))
			camera = 1
			
		called = false
		get_node("/root/Minigame1/Pause3D/PauseLayer/Pause/ColorRect/MarginContainer/VBoxContainer/MenuEntries/Pointer").set_process(true)