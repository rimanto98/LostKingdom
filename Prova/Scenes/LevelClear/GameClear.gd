extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$GameClearSound.play()
	yield(get_tree().create_timer(5),"timeout")
	SceneManager.goto_scene("res://Scenes/Menu/Menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
