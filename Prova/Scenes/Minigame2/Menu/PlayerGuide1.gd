extends KinematicBody2D

const SPEED = 200
var dir = 1

func _ready():
	randomize()
	
func _physics_process(delta):
	var direction = Vector2()
	if $ChangeDir.time_left == 0:
		dir = -dir
		$ChangeDir.start()
		
	direction = Vector2(dir,0) 
	
	move_and_slide(direction * SPEED)
	
	self.update_animations(direction)
	
	
func update_animations(direction):
	
	if direction.x > 0 :
		$AnimatedSprite.play("movingR")
		
	elif direction.x < 0:
		$AnimatedSprite.play("movingL")
		
	else:
		$AnimatedSprite.play("idle")
