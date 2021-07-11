extends Label

var called = false

var guide_node

func _ready():
	var guide_scene = load("res://Scenes/Guide/Guide.tscn")
	guide_node = guide_scene.instance()
	

func callback():
	called = true
	
func _process(delta):
	if called:
		get_node("/root").add_child(guide_node)
		called = false
		
		
		
	if Input.is_action_just_released("ui_cancel"):
		get_node("/root").remove_child(guide_node)
		get_node("/root/Menu/ColorRect/MarginContainer/VBoxContainer/MenuEntries/Pointer").selected = false
		
	