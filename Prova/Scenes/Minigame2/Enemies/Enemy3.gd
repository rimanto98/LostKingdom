extends "res://Scenes/Minigame2/Enemies/Enemy.gd"

var hit = false
var right
var movement = Vector2()
const VELOCITY = 300

func _ready():
	randomize()
	if randf() >= 0.4:
		right = false
		$AnimatedSprite.flip_h = true
		position.x = 2000
		movement = Vector2(-1,0)
		
	else:
		right = true
		position.x = -100
		movement = Vector2(1,0)
	
func _physics_process(delta):
	if self.get_global_position().x >= 2000 && right:
		self.queue_free()
		
	elif self.get_global_position().x <= -100 && !right:
		self.queue_free()
	
	move_and_slide(movement*VELOCITY)
	#print(movement*VELOCITY)
		

func gotHit():
	$"/root/Global".points += 500
	hit = true
	self.set_physics_process(false)
	.gotHit()
	yield(get_tree().create_timer(0.5), "timeout")
	$Sounds/Bonus.play()

