extends KinematicBody2D

const SPEED = 500
const GRAVITY = 20
const JUMP_POWER = -550
const FLOOR = Vector2(0,-1)		#This is a vector pointing straight upward.
								# This means that if the character collides with an object that has this normal,
								# it will be considered a floor.

var velocity = Vector2()

var bombs = 0

signal bomb_taken
signal bomb_dropped
signal view_cabinet_text

var on_ground = false
var facingRight =  true
var hit = false
var dead = false
var attack = false
var invincible = false

func _ready():
	set_physics_process(false)
	if !$"/root/Global".inMinigame:
		$AnimatedSprite.play("door_out")
		yield(get_tree().create_timer(0.8),"timeout")
		
	else:
		var positionCabinet = get_node("/root/Game/Cabinet").position
		position = positionCabinet
		$"/root/Global".inMinigame = false
	set_physics_process(true)

#warning-ignore:unused_argument
func _physics_process(delta):
	
	if $InvincibilityTime.time_left == 0: 
		invincible = false

	if (self.position.y >= 1000):
		fall()
	
	if !dead:
		var condition = 1
		if attack:
			condition = 0.5
		if Input.is_action_pressed("ui_right"):
			velocity.x = SPEED*condition
			
			
		elif Input.is_action_pressed("ui_left"):
			velocity.x = -SPEED*condition
			
			
		else:
			velocity.x = 0
			
			
		if Input.is_action_pressed("ui_up"):
			if on_ground:
				velocity.y = JUMP_POWER
				on_ground = false
				if !$Sounds/JumpSound.playing:
					$Sounds/JumpSound.play()
	
	else:
		velocity.x = 0
			
	velocity.y += GRAVITY
	
	if is_on_floor():
		on_ground = true
		
	else:
		on_ground = false
		
	if bombs > 0 and Input.is_key_pressed(KEY_Z) and $BombsCooldown.time_left == 0:
		$BombsCooldown.start()
		if !on_ground:
			velocity.y = JUMP_POWER
		on_ground = false
		bombs -= 1
		emit_signal("bomb_dropped",bombs)
		launch_bomb()
		
	if Input.is_key_pressed(KEY_X) and $AttackCooldown.time_left == 0:
		attack = true
		$HammerHitbox/HitboxCollision.disabled = false
		$HammerHitbox/ActiveHammerHitbox.start()
		$AttackCooldown.start()
	#print($AttackCooldown.time_left)
	
		
	velocity = move_and_slide(velocity,FLOOR)
	
	self.update_animations()
	
		
func update_animations():
	
	if $AnimatedSprite.flip_h == true:
		if facingRight:
			$Hurtbox.position.x += 15
			$BombRaycast.position.x += 15
			$EnterInteractionSprite.position.x += 15
			$HammerHitbox.position.x -= 40
			facingRight = false

	elif $AnimatedSprite.flip_h == false:
		if !facingRight:
			$Hurtbox.position.x -= 15
			$BombRaycast.position.x -= 15
			$EnterInteractionSprite.position.x -= 15
			$HammerHitbox.position.x += 40
			facingRight = true

	if Global.lives == 0:
		get_node("/root/Game/BackgroundMusic").playing = false
		if !dead:
			$Sounds/gameOver.play()
			deathScreen()
		dead = true	
		$AnimatedSprite.play("death")
		yield(get_tree().create_timer(2.5),"timeout")
		SceneManager.goto_scene("res://Scenes/Menu/Menu.tscn")
			
	elif attack:
		$AnimatedSprite.play("attack")
		if $Sounds/hammerSwing.playing == false:
			$Sounds/hammerSwing.play()
		yield(get_tree().create_timer(0.15),"timeout")
		attack = false
		$HammerHitbox/HitboxCollision.disabled = true

	elif hit:
		$AnimatedSprite.play("hit")
		yield(get_tree().create_timer(0.4),"timeout")
		hit = false
	
	elif !on_ground && velocity.y < 0:
		$AnimatedSprite.play("jump")
		
	elif !on_ground && velocity.y >= 0:
		$AnimatedSprite.play("falling")
	
	elif velocity.x == SPEED:
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = false
		
	elif velocity.x == -SPEED:
		$AnimatedSprite.play("run")
		$AnimatedSprite.flip_h = true
		
	elif on_ground:
		$AnimatedSprite.play("idle")
		

func deathScreen():
	var gameOver_scene = load("res://Scenes/GameOver/GameOver.tscn")
	var gameOver_node = gameOver_scene.instance()
	get_node("/root/Game").add_child(gameOver_node)
		

func _on_Bomb1_increase_bombs():
	bombs += 1
	$Sounds/PickUpBombSound.play()
	emit_signal("bomb_taken",bombs)
	
func reset_after_death():
	$AnimatedSprite.flip_h = false
	self.position.x = 80.039
	self.position.y = 291.774
	
func launch_bomb():
	var bomb_scene = load("res://Entities/Bomb/Bomb.tscn")
	var bomb_node = bomb_scene.instance()
	
	bomb_node.position = self.position + $BombRaycast.cast_to.normalized()*16
	if !facingRight:
		bomb_node.position.x -= 30
		
	else:
		bomb_node.position.x += 10
	bomb_node.apply_impulse(Vector2(),$BombRaycast.cast_to.normalized()*600)
	
	get_node("/root/Game").add_child(bomb_node)
	$Sounds/bombDropSound.play()
	


func _on_Cabinet_in_cabinet_range(text,string):
	$EnterInteractionSprite.show()
	if Input.is_action_just_released("ui_accept"):
			emit_signal("view_cabinet_text",text,string)
			$AnimatedSprite.play("idle")			
			set_physics_process(false)


func _on_TextBox_dialog_finished():
	set_physics_process(true)
	

func _on_Cabinet_out_cabinet_range():
	$EnterInteractionSprite.hide()


func _on_HitBox_player_hit():
	if !invincible:
		Global.death()
		if Global.lives > 0:
			velocity.y = -550
		$Sounds/damageTaken.play()
		hit = true
		invincible = true
		$InvincibilityTime.start()
		
func fall():
	reset_after_death()
	Global.death()
	$Sounds/damageTaken.play()
	hit = true
	invincible = true
	$InvincibilityTime.start()


func _on_Sign_in_cabinet_range(text,string):
	_on_Cabinet_in_cabinet_range(text,string)


func _on_Sign_out_cabinet_range():
	_on_Cabinet_out_cabinet_range()

