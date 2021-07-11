extends ParallaxBackground

var background_class = load("res://Scenes/Minigame1/MenuMinigame3D/BackgroundMenu.tscn")

func _ready():
	var backgorund_instance = background_class.instance()
	add_child(backgorund_instance)

