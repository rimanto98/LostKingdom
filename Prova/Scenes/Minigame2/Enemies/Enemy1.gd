extends "res://Scenes/Minigame2/Enemies/Enemy.gd"

var hit = false
var bullet = preload("res://Scenes/Minigame2/Bullet/EnemyBullet.tscn")
export var fire_rate = 1
export var bullet_speed = 500
var can_fire = true
var attack = false

func _ready():
	randomize()
	$Shoot.wait_time = randi()%10+1
	$Shoot.start()

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
		
	if $Shoot.time_left == 0:
		decideToShoot()
	
	var movement = .getMovement()
	
	move_and_slide(movement)
	self.update_animations(movement)
	
	
func update_animations(direction):
	if hit:
		$AnimatedSprite.play("hit")
		yield(get_tree().create_timer(0.8),"timeout")
		hit = false
		
	elif attack:
		$AnimatedSprite.play("shoot")
		yield(get_tree().create_timer(0.4),"timeout")
		attack = false
	
	elif direction.x > 0 && !hit:
		$AnimatedSprite.play("right")
		
	elif direction.x && !hit:
		$AnimatedSprite.play("left")
		

func gotHit():
	self.set_physics_process(false)
	$"/root/Global".points += 100
	hit = true
	can_fire = false
	.gotHit()
	

func decideToShoot():
	if randf() < 0.5 and can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.position = $BulletPoint.get_global_position()
		bullet_instance.apply_impulse(Vector2(), Vector2(0,bullet_speed))
		$Sounds/EnemyProjectile.play()
		get_tree().get_root().add_child(bullet_instance)
		#$Sounds/CharacterProjectile.play()
		attack = true
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true
	$Shoot.wait_time = randi()%10+1
	$Shoot.start()

