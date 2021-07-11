extends "res://Scenes/Minigame2/Enemies/Enemy.gd"

var lives = 2

var hit = false

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
		
	if self.get_global_position().x >= 1850 && $Timer.time_left == 0:
		var enemies = get_parent().get_children()
		for enemy in enemies:
			enemy.position.y += 50
			enemy.goLeft = true
		$Timer.start()
		
	if self.get_global_position().x <= 70 && $Timer.time_left == 0:
		var enemies = get_parent().get_children()
		for enemy in enemies:
			enemy.position.y += 50
			enemy.goLeft = false
		$Timer.start()
		
	var movement = .getMovement()
	
	move_and_slide(movement)
	self.update_animations(movement)
	
	
func update_animations(direction):
	var version = ""
	if lives < 2:
		version = "v2"
		
	if hit:
		$AnimatedSprite.play(version+"hit")
		yield(get_tree().create_timer(0.8),"timeout")
		hit = false
	
	elif direction.x > 0 && lives > 0:
		$AnimatedSprite.play(version+"right")
		
	elif direction.x && lives > 0:
		$AnimatedSprite.play(version+"left")
			
	
func gotHit():
	hit = true
	lives -= 1

	if lives == 0:
		self.set_physics_process(false)
		$"/root/Global".points += 150
		.gotHit()
	
	else:
		$Sounds/ShieldDown.play()

func _on_Enemy_right(dir):
	if dir:
		goLeft = false
	else:
		goLeft = true


func _on_Enemy2_right(dir):
	if dir:
		goLeft = false
	else:
		goLeft = true
