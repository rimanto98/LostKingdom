extends KinematicBody2D

var movement = Vector2()
var speed = 250
const GRAVITY = 20
const FLOOR = Vector2(0,-1)

var facingRight =  true

var startingPos

func _ready():
	randomize()
	startingPos = position
	
func _process(delta):
	if movement.y >= 1000:
		self.queue_free()
		#print("eliminato")
		
	if $Timer.time_left == 0:
		$Timer.start()
		
		if randf() < 0.5:
			movement = Vector2()
			
		else:
			movement = get_random_direction()
		
	movement.y += GRAVITY
	
	if is_on_wall():
		if position.x < startingPos.x:
			movement.x = speed
		elif position.x > startingPos.x:
			movement.x = -speed	
			
	movement = move_and_slide(movement,FLOOR)
	
	update_animations(movement)
	
	
func get_random_direction():
	var random_direction = Vector2()
	var rand_float = randf()
	
	if rand_float < 0.5:
		random_direction.x = -speed 
		
	else:
		random_direction.x = speed
		
	random_direction.y = 0
		
	return random_direction 
	
	
func update_animations(velocity):
	
	if $AnimatedSprite.flip_h == false:
		if facingRight:
			$Collision.position.x += 5
			$HitBox/HitBoxCollision.position.x += 5
			$HurtBox/HurtBoxCollision.position.x += 5
			facingRight = false

		
	elif $AnimatedSprite.flip_h == true:
		if !facingRight:
			$Collision.position.x -= 5
			$HitBox/HitBoxCollision.position.x -= 5
			$HurtBox/HurtBoxCollision.position.x -= 5
			facingRight = true

	
	if velocity.x == -speed:
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = false
		
	elif velocity.x == speed:
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = true
		
	else:
		$AnimatedSprite.play("idle")


func _on_HurtBox_enemy_death():
	$HitBox/HitBoxCollision.disabled = true
	$HurtBox/HurtBoxCollision.disabled = true
	$Collision.disabled = true
	set_process(false)
	$enemyKilled.play()
	$AnimatedSprite.play("death")
	yield(get_tree().create_timer(0.6),"timeout")
	self.queue_free()
