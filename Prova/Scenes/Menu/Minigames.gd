extends Label

onready var SAVE_KEY: String = name

func _ready():
	if $"/root/Global".unlockM1 or $"/root/Global".unlockM2:
		modulate.a = 1

func save(save_game: Resource):
	save_game.data[SAVE_KEY] = {
		'visibility': modulate.a
	}


func load(save_game: Resource):
	var data: Dictionary = save_game.data[SAVE_KEY]
	modulate.a = data['visibility']
	
	
func callback():
	var path = "/root/Menu/ColorRect/MarginContainer/VBoxContainer/MenuEntries/"
	for node in get_parent().get_children():
		if node is Label and node.visible:
			node.hide()
		else:
			node.show()
	get_node(path+"Pointer").restart()