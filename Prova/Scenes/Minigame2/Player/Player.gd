extends KinematicBody2D

const SPEED = 800
export var bullet_speed = 500
export var fire_rate = 1

var bullet = preload("res://Scenes/Minigame2/Bullet/Bullet.tscn")
var can_fire = true
var attack = false
var hit = false

var target = 0

var controlledByAi = false

signal lifeLost
signal dead

var lives = 3

func _process(delta):
		
	if Input.is_action_pressed("fire") and can_fire and !controlledByAi:
		shoot()
	
func _physics_process(delta):
	var direction = Vector2()
	
	if controlledByAi:
		if self.get_global_position().x < target+40 && self.get_global_position().x > target-40 and can_fire:
			shoot()
			$AnimatedSprite.play("shoot")
			self.set_physics_process(false)
			yield(get_tree().create_timer(1),"timeout")
			self.set_physics_process(true)
			
		elif self.get_global_position().x > target && self.get_global_position().x > 70:
			direction += Vector2(-1, 0)
		elif self.get_global_position().x < target && self.get_global_position().x < 1840:
			direction += Vector2(1, 0)

	else:
		if Input.is_action_pressed("ui_left") && self.get_global_position().x > 70:
			direction += Vector2(-1, 0)
		if Input.is_action_pressed("ui_right") && self.get_global_position().x < 1840:
			direction += Vector2(1, 0)
	
	move_and_slide(direction * SPEED)
	
	self.update_animations(direction)
	
	
func update_animations(direction):
	if lives == 0:
		get_node("/root/SpaceInvadersAI/BackgroundMusic").playing = false
		#if !dead:
		#	$Sounds/gameOver.play()
		#	deathScreen()
		#dead = true	
		$AnimatedSprite.play("death")
		yield(get_tree().create_timer(2.5),"timeout")
		SceneManager.goto_scene("res://Scenes/Menu/Menu.tscn")
			
	elif attack:
		$AnimatedSprite.play("shoot")
		yield(get_tree().create_timer(0.15),"timeout")
		attack = false

	elif hit:
		$AnimatedSprite.play("hit")
		yield(get_tree().create_timer(0.8),"timeout")
		hit = false
	
	elif direction.x > 0 :
		$AnimatedSprite.play("movingR")
		
	elif direction.x < 0:
		$AnimatedSprite.play("movingL")
		
	else:
		$AnimatedSprite.play("idle")
		
	
func gotHit():
	if $Invincibility.time_left == 0:
		lives -= 1
		if lives <= 0:
			self.set_physics_process(false)
			$CollisionShape2D.disabled = true
			$CollisionShape2D.scale = Vector2(0.001,0.001)
			yield(get_tree().create_timer(0.2),"timeout")
			$AnimatedSprite.hide()
			$Sounds/CharacterDeath.play()
			$Particles2D.emitting = true
			yield(get_tree().create_timer(0.9),"timeout")
			emit_signal("dead")
			self.queue_free()
		$Sounds/CharacterHit.play()
		emit_signal("lifeLost",lives)
		hit = true
		$Invincibility.start()
	#print (lives)


func _on_SpaceInvadersAI_aiOutput(value):
	#print(value)
	#aggiungo l'offset per sparare calcolando il tempo di arrivo
	if self.get_global_position().x >= value +69:
		target = value-130
		
	elif self.get_global_position().x < value-70:
		target = value+130
		
	#print (target)
	
func shoot():
	var bullet_instance = bullet.instance()
	bullet_instance.position = $BulletPoint.get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(), Vector2(0,-bullet_speed))
	get_tree().get_root().add_child(bullet_instance)
	$Sounds/CharacterProjectile.play()
	attack = true
	can_fire = false
	yield(get_tree().create_timer(fire_rate), "timeout")
	can_fire = true


func deathScreen():
	var gameOver_scene = load("res://Scenes/GameOver/GameOver.tscn")
	var gameOver_node = gameOver_scene.instance()
	get_node("/root/SpaceInvadersAI").add_child(gameOver_node)