extends Label

var called = false

var guide_node

signal guide

func _ready():
	var guide_scene = load("res://Scenes/Guide/Guide.tscn")
	guide_node = guide_scene.instance()
	

func callback():
	called = true
	
func _process(delta):
	if called:
		get_node("/root/Game/Player/Camera2D/PauseLayer").add_child(guide_node)
		called = false
		emit_signal("guide",true)
		
	if Input.is_action_just_released("ui_cancel") && get_node("/root/Game/Player/Camera2D/PauseLayer/Pause").visible:
		get_node("/root/Game/Player/Camera2D/PauseLayer").remove_child(guide_node)
		get_node("/root/Game/Player/Camera2D/PauseLayer/Pause/ColorRect/MarginContainer/VBoxContainer/MenuEntries/Pointer").set_process(true)
		emit_signal("guide",false)


		
	