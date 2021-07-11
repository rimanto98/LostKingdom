extends Label

var unlocked = false

onready var SAVE_KEY: String = name
# Called when the node enters the scene tree for the first time.
func _ready():
	if $"/root/Global".unlockM1:
		modulate.a = 1
		text = "Sumo Ball 3D"

func callback():
	$"/root/Global".fromMenu = true
	var fade_class = load("res://Scenes/Fade/Fade.tscn")
	get_parent().add_child(fade_class.instance())
	yield(get_tree().create_timer(0.7),"timeout")
	SceneManager.goto_scene("res://Scenes/Minigame1/MenuMinigame3D/Menu.tscn")

func save(save_game: Resource):
	save_game.data[SAVE_KEY] = {
		'unlocked' : $"/root/Global".unlockM1
	}


func load(save_game: Resource):
	var data: Dictionary = save_game.data[SAVE_KEY]
	unlocked = data['unlocked']
	if unlocked : 
		modulate.a = 1
		text = "Sumo Ball 3D"
		$"/root/Global".unlockM1 = true
		
func _process(delta):
	if visible && Input.is_action_just_released("ui_cancel"):
		var path = "/root/Menu/ColorRect/MarginContainer/VBoxContainer/MenuEntries/"
		for node in get_parent().get_children():
			if node is Label and node.visible:
				node.hide()
			else:
				node.show()
		get_node(path+"Pointer").restart()
