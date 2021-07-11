extends Label

var fade_class = load("res://Scenes/Fade/Fade.tscn")
	
func _ready():
	self.modulate.a = 0
	$Timer.start()
	if !$Music.playing:
		$Music.play()

# Called when the node enters the scene tree for the first time.
func _process(delta):
	if self.modulate.a < 1:
		self.modulate.a += 0.5 *delta
		
	if $Timer.time_left == 0:
		get_parent().add_child(fade_class.instance())
		yield(get_tree().create_timer(0.7),"timeout")
		SceneManager.goto_scene("res://Scenes/Minigame2/Menu/Menu.tscn")