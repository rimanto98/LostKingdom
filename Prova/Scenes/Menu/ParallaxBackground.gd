extends ParallaxBackground

var background_class = load("res://Scenes/Menu/MenuBackground.tscn")

func _ready():
	var backgorund_instance = background_class.instance()
	add_child(backgorund_instance)
