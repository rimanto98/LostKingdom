extends KinematicBody2D

const SPEED = 800
export var bullet_speed = 500
export var fire_rate = 1

var bullet = preload("res://Scenes/Minigame2/Bullet/Bullet.tscn")
var can_fire = true
var attack = false
var dir = 1

func _ready():
	randomize()
	
func _physics_process(delta):
	var direction = Vector2()
	
	if $Shoot.time_left == 0:
		$Shoot.start()
		shoot()
		
	
	if $ChangeDir.time_left == 0:
		dir = -dir
		$ChangeDir.start()
		
	direction = Vector2(dir,0) 
	
	move_and_slide(direction * SPEED)
	
	self.update_animations(direction)
	
	
func update_animations(direction):
	if attack:
		$AnimatedSprite.play("shoot")
		yield(get_tree().create_timer(0.15),"timeout")
		attack = false
	
	elif direction.x > 0 :
		$AnimatedSprite.play("movingR")
		
	elif direction.x < 0:
		$AnimatedSprite.play("movingL")
		
	else:
		$AnimatedSprite.play("idle")
	

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