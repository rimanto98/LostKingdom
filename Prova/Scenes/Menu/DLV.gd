extends Label

onready var SAVE_KEY: String = name

var unlocked = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if $"/root/Global".unlockM2:
		modulate.a = 1
		text = "Space Battle AI"
		
func callback():
	$"/root/Global".fromMenu = true
	var fade_class = load("res://Scenes/Fade/Fade.tscn")
	get_parent().add_child(fade_class.instance())
	yield(get_tree().create_timer(0.7),"timeout")
	SceneManager.goto_scene("res://Scenes/Minigame2/Menu/Menu.tscn")

func save(save_game: Resource):
	save_game.data[SAVE_KEY] = {
		'unlocked' : $"/root/Global".unlockM2
	}


func load(save_game: Resource):
	var data: Dictionary = save_game.data[SAVE_KEY]
	unlocked = data['unlocked']
	if unlocked : 
		modulate.a = 1
		text = "Space Battle AI"
		$"/root/Global".unlockM2 = true
		