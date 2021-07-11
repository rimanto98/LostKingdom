extends AnimatedSprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	set_process(false)
	play("door_out")
	yield(get_tree().create_timer(0.8),"timeout")
	set_process(true)
	$NewAnimation.start()

func _process(delta):	
	if $NewAnimation.time_left == 0:
		newAnimation()	
	else:
		play("idle")
	
func newAnimation():
	var value = randf()
	
	if value < 0.5:
		play("run")
		set_process(false)
		yield(get_tree().create_timer(6),"timeout")
		set_process(true)
		
	elif value < 0.85:
		play("attack")
		set_process(false)
		yield(get_tree().create_timer(0.4),"timeout")
		set_process(true)
		
	elif value < 1:
		play("hit")
		set_process(false)
		yield(get_tree().create_timer(1.2),"timeout")
		set_process(true)
		
	$NewAnimation.start()
		