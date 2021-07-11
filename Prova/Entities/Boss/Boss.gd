extends KinematicBody2D

var movement = Vector2()
var speed = 400
const GRAVITY = 20
const FLOOR = Vector2(0,-1)

var facingRight =  false
var on_ground = false
var attack = false
var jump = false
var hit = false
var invincible = false

var lives = 10

var startingPos

signal game_clear


func _ready():
	randomize()
	startingPos = position
	
	
func _process(delta):
	
	if $InvincibilityTime.time_left == 0: 
		invincible = false
	
	if movement.y >= 1000:
		self.queue_free()
		#print("eliminato")
		
	if $Timer.time_left == 0:
		$Timer.start()
		
		if randf() < 0.3:
			movement = Vector2()
			
		else:
			get_random_direction()
		
		decide()

	if !get_node("/root/Game/Player").on_ground && jump && on_ground:
		movement.y = -550
		
	movement.y += GRAVITY
	
	if is_on_wall():
		changeFacingDirection()
		if position.x < startingPos.x:
			movement.x = speed
		elif position.x > startingPos.x:
			movement.x = -speed	
			
	movement = move_and_slide(movement,FLOOR)
	
	if is_on_floor():
		on_ground = true
	else:
		on_ground = false
	
	update_animations(movement)
	
	
func decide():
	if randf() < 0.2:
		jump = true
	else:
		jump = false
	
	if randf() < 0.5 && !hit:
		attack = true
		$PunchHitBox/HitBox.disabled = false
		
	
func get_random_direction():
	if randf() < 0.5:
		movement.x = -speed 
		
	else:
		movement.x = speed
		

func changeFacingDirection():
	if !facingRight and position.x < startingPos.x:  
		$AnimatedSprite.flip_h = true
		$PunchHitBox/HitBox.position.x += 30
		facingRight = true
			
	elif facingRight and position.x > startingPos.x:
		$AnimatedSprite.flip_h = false
		$PunchHitBox/HitBox.position.x -= 30
		facingRight = false
		
		
func update_animations(velocity):
	
	if $AnimatedSprite.flip_h == true:
		if !facingRight:
			$PunchHitBox/HitBox.position.x += 30
			facingRight = true

	elif $AnimatedSprite.flip_h == false:
		if facingRight:
			$PunchHitBox/HitBox.position.x -= 30
			facingRight = false
			
	if hit:
		$AnimatedSprite.play("hit")
		yield(get_tree().create_timer(0.4),"timeout")
		hit = false
	
	elif attack:
		$AnimatedSprite.play("attack")
		yield(get_tree().create_timer(0.6),"timeout")
		attack = false
		$PunchHitBox/HitBox.disabled = true

	
	elif !on_ground && velocity.y < 0:
		$AnimatedSprite.play("jump")
		
	elif !on_ground && velocity.y >= 0:
		$AnimatedSprite.play("falling")
	
	elif velocity.x == -speed:
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = false
		
	elif velocity.x == speed:
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = true
		
	else:
		$AnimatedSprite.play("idle")


func _on_HurtBox_enemy_death():
	if !invincible:
		lives -= 1
		hit = true
		if lives == 0:
			$HitBox/HitBoxCollision.disabled = true
			$HurtBox/HurtBoxCollision.disabled = true
			#$Collision.disabled = true
			set_process(false)
			$Sounds/enemyKilled.play()
			$AnimatedSprite.play("death")
			yield(get_tree().create_timer(0.6),"timeout")
			self.queue_free()
			emit_signal("game_clear")
		else:
			$Sounds/bossHurt.play()
		invincible = true
		$InvincibilityTime.start()
