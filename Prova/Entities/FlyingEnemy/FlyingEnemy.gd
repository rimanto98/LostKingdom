extends Node2D

var dir = 1
var velocity = 2

var startingPos

func _ready():
	randomize()
	startingPos = position
	
func _process(delta):
	if $ChangeDirection.time_left == 0:
		dir = -dir
		$ChangeDirection.start()
	position.y += dir*velocity
	$AnimatedSprite.play("fly")

	
func _on_HurtBox_enemy_death():
	$HitBox/HitBoxCollision.disabled = true
	$HurtBox/HurtBoxCollision.disabled = true
	set_process(false)
	$enemyKilled.play()
	$AnimatedSprite.play("death")
	yield(get_tree().create_timer(0.6),"timeout")
	self.queue_free()
