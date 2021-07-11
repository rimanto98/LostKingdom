extends ViewportContainer

var fade_class = load("res://Scenes/Fade/Fade.tscn")

var dir = 1

func _ready():
	var fade_instance = fade_class.instance()
	fade_instance.set_fade_in(true)
	add_child(fade_instance)

func _on_AnimationPlayer_animation_finished(anim_name):
	if dir:
		$ParallaxBackground/AnimationPlayer.play_backwards("MenuBackground")
		dir = 0
	else:
		$ParallaxBackground/AnimationPlayer.play("MenuBackground")
		dir = 1
