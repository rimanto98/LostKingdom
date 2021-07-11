extends Area2D

var started = false

var hit = false

func _physics_process(delta):
	
	if hit:
		$HitTime.start()
		
	if $HitTime.time_left == 0:
		hit = false	
	
	if !started:
		$ActiveTime.start()
		$Explosion.play("explosion")
		$ExplosionSound.play()
		started = true
		
	elif started and $ActiveTime.time_left == 0:
		self.queue_free()
		
	elif started and $ActiveTime.time_left > 0:
		var bodies = self.get_overlapping_bodies()
		for body in bodies:
			if "Player" in body.name and !hit:
				body._on_HitBox_player_hit()
				hit = true
			#print(body.name)
			if "Enemy" in body.name:
				body._on_HurtBox_enemy_death()
				#body.queue_free() 
				
				
	
