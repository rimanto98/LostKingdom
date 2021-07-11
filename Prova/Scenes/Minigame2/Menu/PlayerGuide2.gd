extends KinematicBody2D

export var bullet_speed = 500
export var fire_rate = 1

var bullet = preload("res://Scenes/Minigame2/Bullet/Bullet.tscn")
var can_fire = true
var attack = false

func _ready():
	randomize()
	
func _physics_process(delta):
	
	if $Shoot.time_left == 0:
		$Shoot.start()
		shoot()
	
	self.update_animations()
	
	
func update_animations():
	if attack:
		$AnimatedSprite.play("shoot")
		yield(get_tree().create_timer(0.15),"timeout")
		attack = false
		
	else:
		$AnimatedSprite.play("idle")
	

func shoot():
	var bullet_instance = bullet.instance()
	var children = bullet_instance.get_children()
	for child in children:
		if child.name == "CollisionShape2D":
			child.disabled = true
	
	#bullet_instance.pause_mode = Node.PAUSE_MODE_PROCESS
	#print (bullet_instance.pause_mode)
	bullet_instance.position = $BulletPoint.get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(), Vector2(0,-bullet_speed))
	get_parent().get_parent().add_child(bullet_instance)
	attack = true
	can_fire = false
	yield(get_tree().create_timer(fire_rate), "timeout")
	can_fire = true